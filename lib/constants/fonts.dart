import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dimensions.dart';

class SmallTextType extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  const SmallTextType({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.size = 16,
    this.weight = FontWeight.w600
  });


  @override
  Widget build(BuildContext context) {
    double sizeV = screenWidth(context)*0.045;
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: (size==16)? sizeV:size,
        fontWeight: weight,
      ),
    );
  }
}
