import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:giphyapp/SearchGiphy/view/SearchGiphyScreen.dart';


class SignIn_Controller extends GetxController {
  Rx<TextEditingController> number = TextEditingController().obs;
  TextEditingController password = TextEditingController();
  bool isLoading1 = false;
  bool isLoading = false;
  bool isObsecure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginUserWithEmailAndPassword(
      String email, String passwords) async {
    isLoading = true;
    try {
      if (number.value.text.isNotEmpty && passwords.isNotEmpty) {
        final cred = await _auth.signInWithEmailAndPassword(
            email: email, password: passwords);
        Get.off(SearchGiphyScreen());
        EasyLoading.showSuccess('Login successful!');
        isLoading = false;

        number.value.clear();
        password.clear();
        return cred.user;
      }
    } catch (e) {
      log("Something went wrong");

      EasyLoading.showError("Invalid credentials");
    }
    return null;
  }

  Future<String> signupUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.off(SearchGiphyScreen());
        print(cred.user!.uid);

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  void ispass() {
    if (isObsecure == false) {
      isObsecure = true;
      update();
    } else {
      isObsecure = false;
      update();
    }
  }

  void check_len() {
    number.value.text.length;
    password.text;
    update();
  }
}
