import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/controller/auth.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    controller.init();
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.logIn.value ? "Log In" : "Sign Up"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: controller.formKey,
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (!controller.logIn.value) ...[
                      TextFormField(
                        controller: controller.fullNameController,
                        validator: controller.fullNameValidator,
                        decoration: const InputDecoration(hintText: "Full Name"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                    TextFormField(
                      controller: controller.emailController,
                      validator: controller.emailValidator,
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller.passwordController,
                      validator: (value) => controller.passwordValidator(value, false),
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon: Icon(
                            controller.hidePassword.value ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (!controller.logIn.value)
                      TextFormField(
                        obscureText: controller.hideConfirmPassword.value,
                        controller: controller.confirmPasswordController,
                        validator: (value) => controller.passwordValidator(value, true),
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(
                            onPressed: () => controller.hideConfirmPassword.value = !controller.hideConfirmPassword.value,
                            icon: Icon(
                              controller.hideConfirmPassword.value ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: controller.changeMode,
                  child: Obx(
                    () => Text(
                      controller.logIn.value ? "Create Account" : "Log In",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: controller.validate,
                  child: Obx(
                    () => Text(controller.logIn.value ? "Log In" : "Sign Up"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
