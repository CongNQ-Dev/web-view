import 'dart:async';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/apis/customer.dart';
import '../../common/entities/customer.dart';
import '../../routes/routes.dart';
import '../../store/customer.dart';
import 'index.dart';

class SignInController extends GetxController {
  SignInController();
  final state = SignInState();
  final myInputPhoneController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? user;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  Future<void> handleSignIn(String type) async {
    //1: google, 2: facebook, 3: apple, 4: phone
    try {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      late ExternalLogin? externalLogin;
      switch (type) {
        case "phoneNumber":
          state.phoneNumber.value = myInputPhoneController.text;
          await auth.verifyPhoneNumber(
            phoneNumber: "+84${myInputPhoneController.text}",
            verificationCompleted: (credential) async {
              // final UserCredential userCredential =
              //     await auth.signInWithCredential(credential);
            },
            codeSent: (verificationId, forceResendingToken) {
              state.verificationId.value = verificationId;
              startResendTimer();
              Get.toNamed(AppRoutes.otpConfirm);
            },
            codeAutoRetrievalTimeout: (verificationId) {
              state.verificationId.value = verificationId;
            },
            verificationFailed: (e) {
              startResendTimer();
              if (e.code == 'invalid-phone-number') {
                Get.snackbar('Error', 'The provided phone number is not valid');
              } else {
                Get.snackbar('Error', 'Something went wrong. Try again');
              }
            },
          );
          break;
        case "google":
          GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
          final UserCredential userCredential =
              await auth.signInWithProvider(googleAuthProvider);
          final User user = userCredential.user!;
          final idToken = await user.getIdToken();
          String? providerId = userCredential.additionalUserInfo!.providerId;
          externalLogin = ExternalLogin(idToken: idToken, provider: providerId);
          break;
        case "facebook":
          if (kDebugMode) {
            print("... you are logging in with facebook");
          }
          break;
        default:
          if (kDebugMode) {
            print("...login type not sure...");
          }
          break;
      }
      if (externalLogin != null) {
        await asyncPostAllDataCustomer(externalLogin);
      }
    } catch (e) {
      // EasyLoading.dismiss();
      if (kDebugMode) {
        print("...error login with $e");
      }
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: state.verificationId.value, smsCode: otp));
      final User user = credential.user!;
      final idToken = await user.getIdToken();
      String? providerId = credential.additionalUserInfo!.providerId;
      var externalLogin = ExternalLogin(idToken: idToken, provider: providerId);
      await asyncPostAllDataCustomer(externalLogin);
      EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Try again');
      EasyLoading.dismiss();
    }
  }

  Future<void> resendOtp() async {
    try {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      await auth.verifyPhoneNumber(
        phoneNumber: "+84${state.phoneNumber.value}",
        verificationCompleted: (credential) async {},
        codeSent: (verificationId, forceResendingToken) {
          state.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          state.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid');
          } else {
            Get.snackbar('Error', 'Something went wrong. Try again');
          }
        },
      );
      EasyLoading.dismiss();
      startResendTimer();
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Try again');
      EasyLoading.dismiss();
    }
  }

  Future<void> asyncPostAllDataCustomer(ExternalLogin externalLogin) async {
    try {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var result = await CustomerAPI.login(params: externalLogin);
      if (result.access_token != null) {
        await CustomerStore.to.saveProfile(CustomerItem(
            access_token: result.access_token,
            tokenType: result.tokenType,
            userID: result.userID,
            expiresIn: result.expiresIn,
            userName: result.userName,
            phoneNumber: result.phoneNumber,
            name: result.userName,
            avatar: result.avatar,
            dateLogin: DateTime.now().toString()));
        EasyLoading.dismiss();
        Get.offAllNamed(AppRoutes.main, parameters: {"tabSelected": "0"});
      }
    } on DioException catch (e) {
      Get.snackbar("Error", e.response.toString());
      EasyLoading.dismiss();
    }
  }

  void startResendTimer() {
    state.canResend.value = false;
    state.secondsRemaining.value = 30;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        state.secondsRemaining--;
      } else {
        timer.cancel();
        state.canResend.value = true;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
