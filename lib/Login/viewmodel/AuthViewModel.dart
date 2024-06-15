import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading.value = false;
      return userCredential.user;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Sign In Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  // Method to validate email format
  bool validateEmail(String email) {
    String emailRegex =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // This regex may not cover all edge cases
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }
}
