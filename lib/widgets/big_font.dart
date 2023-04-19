// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigFont extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  BigFont(
      {super.key,
      this.color = Colors.white,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.size = 20,
      this.fontWeight = FontWeight.bold,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: 1,
      overflow: overflow,
      style: GoogleFonts.quicksand(
        textStyle: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
        ),
      ),
    );
  }
}
