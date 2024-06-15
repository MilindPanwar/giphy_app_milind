import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/widgets/CustomButton.dart';
import '../../Login/viewmodel/SignIn_Controller.dart';

class signUp_page extends StatefulWidget {
  signUp_page({super.key});

  @override
  State<signUp_page> createState() => _signUp_pageState();
}

class _signUp_pageState extends State<signUp_page> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignIn_Controller>(
      builder: (auth) {
        return Scaffold(
          backgroundColor: Colors.blueGrey[900], // Set dark bluish background color
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: auth.number.value,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.blueAccent, // Set cursor color
                  style: GoogleFonts.poppins(color: Colors.white), // Apply Poppins font with white color
                  decoration: InputDecoration(
                    labelText: "Email address",
                    labelStyle: GoogleFonts.poppins(color: Colors.white), // Apply Poppins font with white color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(
                        color: Colors.blueAccent, // Border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blueAccent, // Border color when focused
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[700], // Background color for text field
                  ),
                  onChanged: (value) {
                    auth.check_len();
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: auth.password,
                  obscureText: auth.isObsecure,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.blueAccent, // Set cursor color
                  style: GoogleFonts.poppins(color: Colors.white), // Apply Poppins font with white color
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: GoogleFonts.poppins(color: Colors.white), // Apply Poppins font with white color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(
                        color: Colors.blueAccent, // Border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blueAccent, // Border color when focused
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[700], // Background color for text field
                    suffixIcon: IconButton(
                      icon: Icon(
                        auth.isObsecure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.blueAccent, // Icon color
                      ),
                      onPressed: auth.ispass,
                    ),
                  ),
                  onChanged: (value) {
                    auth.check_len();
                  },
                ),
                const SizedBox(height: 20),
                AuthButton(
                  radius: 10,
                  text: auth.isLoading1 ? 'Loading...' : 'SIGNUP',
                  height: 50,
                  color: auth.number.value.text.isNotEmpty ? Colors.blue.shade600 : Colors.grey,
                  ontap: () {
                    if (auth.number.value.text.isEmpty) {
                      EasyLoading.showInfo("Email is Empty");
                    } else if (auth.password.text.isEmpty) {
                      EasyLoading.showInfo("Enter the password");
                    } else {
                      auth.signupUser(
                        email: auth.number.value.text,
                        password: auth.password.text,
                      );
                    }
                  },
                  text_color: Colors.white,
                  width: Get.width * 0.4,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold), // Apply Poppins font
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}