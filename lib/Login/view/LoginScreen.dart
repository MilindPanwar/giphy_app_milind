import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/AuthViewModel.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.14),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Text("Welcome to", style: TextStyle(fontSize: 24)),
              SizedBox(height: 2),
              Text("Sign in Page", style: TextStyle(fontSize: 24)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                "Please enter your Email address and password",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                height: 62,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GetBuilder<AuthService>(
                      builder: (auth) => TextFormField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Email address",
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 20, left: 7),
                        ),
                        onChanged: (value) {
                          auth.validateEmail(value);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                height: 62,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GetBuilder<AuthService>(
                      builder: (auth) => TextField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 20, left: 7),
                        ),
                        onChanged: (value) {
                          // Handle password change
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              GetBuilder<AuthService>(
                builder: (auth) => ElevatedButton(
                  onPressed: () async {
                    // Perform login logic
                    User? user = await _authService.signInWithEmailAndPassword(
                      "email@example.com",
                      "password",
                    );
                    if (user != null) {
                      // Navigate to home page or next screen on success
                      // Example: Get.offAllNamed('/home');
                    }
                  },
                  child: auth.isLoading.value
                      ? CircularProgressIndicator()
                      : Text("Login"),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign up page
                    },
                    child: Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
