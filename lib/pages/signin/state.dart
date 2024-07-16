import 'dart:async';

import 'package:get/get.dart';

class SignInState {
  RxBool isObscured = true.obs;
  var verificationId = ''.obs;
  var phoneNumber = ''.obs;

  var canResend = false.obs;
  var secondsRemaining = 30.obs;
}
