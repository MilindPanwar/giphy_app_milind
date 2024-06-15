import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget headerForAuth(){
  return      Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child:                       Text(
      'GIPHY APP',
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}