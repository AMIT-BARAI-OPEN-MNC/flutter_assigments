import 'package:flutter/material.dart';
import 'package:flutter_assigments/core/database/login_Status.dart';
import 'package:flutter_assigments/core/services/navigation_services.dart';
import 'package:flutter_assigments/routes/app_routs.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final String validEmail = "user@maxmobility.in";
  final String validPassword = "Abc@#123";

  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void validateEmail(String email) {
    isEmailValid.value = GetUtils.isEmail(email);
  }

  void validatePassword(String password) {
    isPasswordValid.value = password.length >= 6;
  }

  // Login Function
  void login() {
    if (formKey.currentState!.validate()) {
      if (emailController.text == validEmail &&
          passwordController.text == validPassword) {
        Get.snackbar("Success", "Login Successful!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        LocalStorage.setLoginState(true);
        NavigationService.pushReplacement(AppRoutes.customerList);
      } else {
        Get.snackbar("Error", "Invalid Credentials",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
  }
}
