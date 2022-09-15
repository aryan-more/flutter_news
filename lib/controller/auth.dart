import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news/widgets/dialog/loading.dart';

class AuthController extends GetxController {
  RxBool logIn = true.obs;
  RxBool hidePassword = true.obs;
  RxBool hideConfirmPassword = true.obs;

  void changeMode() {
    logIn.value = !logIn.value;
    formKey.currentState!.reset();
  }

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void init() {
    fullNameController = TextEditingController();

    emailController = TextEditingController();

    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  String? emailValidator(String? email) {
    assert(email != null);

    if (email!.isEmpty) {
      return "Email cannot be empty";
    }

    if (!EmailValidator.validate(email)) {
      return "Invalid email";
    }

    return null;
  }

  String? fullNameValidator(String? fullName) {
    assert(fullName != null);

    if (fullName!.isEmpty) {
      return "Fullname cannot be empty";
    }
    if (fullName.length < 5) {
      return "Fullname at least contain 5 charactes";
    }
    return null;
  }

  String? passwordValidator(String? password, bool confirm) {
    assert(password != null);

    final String field = confirm ? "Confirm Password" : "Password";

    if (password!.isEmpty) {
      return "$field cannot be empty";
    }
    if (password.length < 8) {
      return "$field at least contain 8 charactes";
    }

    if (!logIn.value && passwordController.text != confirmPasswordController.text) {
      return "$field doesn't match";
    }

    // if (estimatePasswordStrength(password) < 0.3) {
    //   return "Weak password";
    // }
    return null;
  }

  void validate() {
    Loading.showUntil(() async {
      if (formKey.currentState!.validate()) {
        try {
          final instance = FirebaseAuth.instance;

          if (logIn.value) {
            await instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
          } else {
            final uid = await instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
            FirebaseFirestore.instance.collection("username").doc(uid.user!.uid).set({"name": fullNameController.text});
          }
        } on FirebaseAuthException catch (_) {
          throw Exception(_.code);
        } catch (_) {
          throw Exception("Something went wrong");
        }
      }
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
