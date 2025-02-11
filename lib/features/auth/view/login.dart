import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_assigments/features/auth/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: loginController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),

                Obx(() => TextFormField(
                      controller: loginController.emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: loginController.isEmailValid.value
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                      onChanged: (value) =>
                          loginController.validateEmail(value),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Enter Email";
                        if (!GetUtils.isEmail(value))
                          return "Enter a valid Email";
                        return null;
                      },
                    )),
                SizedBox(height: 20),
                Obx(() => TextFormField(
                      controller: loginController.passwordController,
                      obscureText: loginController.isPasswordHidden.value,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(loginController.isPasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () =>
                              loginController.togglePasswordVisibility(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: loginController.isPasswordValid.value
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                      onChanged: (value) =>
                          loginController.validatePassword(value),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Enter Password";
                        if (value.length < 6)
                          return "Password must be at least 6 characters";
                        return null;
                      },
                    )),
                SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loginController.login,
                    child: Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
