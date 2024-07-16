import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../values/colors.dart';
import '../signin/controller.dart';
import 'index.dart';

class OtpConfirmPage extends GetView<OtpConfirmController> {
  const OtpConfirmPage({super.key});
  @override
  Widget build(BuildContext context) {
    final signInController = Get.find<SignInController>();
    Size size = MediaQuery.of(context).size;
    return Obx(() => Container(
          height: size.height,
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(""),
              ),
              body: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(30),
                      child: Text(
                          style: const TextStyle(fontSize: 15),
                          "Nhập mã gồm 6 chữ số được gửi tới số +84 ${signInController.state.phoneNumber.value} thông qua tin nhắn sms"),
                    ),
                    Container(
                      // height: size.height * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 0.9,
                            margin: const EdgeInsets.only(bottom: 15),
                            height: 46,
                            child: TextField(
                              autofocus: true,
                              controller: controller.myInputOtpController,
                              keyboardType: TextInputType.phone,
                              autocorrect: true,
                              decoration: const InputDecoration(
                                hintText: "000000",
                                hintStyle: TextStyle(
                                    fontSize:
                                        25), // Thay đổi kích thước của hintText ở đây

                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                          Container(
                            height: 46,
                            width: size.width * 0.9,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.primaryElement),
                              ),
                              child: const Text(
                                "Tiếp tục",
                                style: TextStyle(
                                    color: AppColors.primaryElementText),
                              ),
                              onPressed: () {
                                signInController.verifyOTP(
                                    controller.myInputOtpController.text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        "Bạn chưa nhận được mã?",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.all(30),
                      child: TextButton(
                          onPressed: signInController.state.canResend.value
                              ? () {
                                  signInController.resendOtp();
                                }
                              : null,
                          child: Text(
                            signInController.state.canResend.value
                                ? "Nhận mã mới"
                                : "Nhận mã mới sau ${signInController.state.secondsRemaining}",
                            style: TextStyle(
                                fontSize: 15,
                                color: signInController.state.canResend.value
                                    ? AppColors.blue
                                    : Colors.grey),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
