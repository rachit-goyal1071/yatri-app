import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';
import '../../../constants/dimensions.dart';
import '../../../constants/fonts.dart';

Widget basicTextField(
    TextEditingController controller,
    String assetPath,
    String hintText,
    String title,
    BuildContext context
    ) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      // border: Border.all(color: Colors.grey),
      boxShadow: kElevationToShadow[1],
      color: secondaryYatriGreenColor,
    ),
    // padding: EdgeInsets.all(screenHeight(context)*0.01),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title (Label)
        // Text(
        //   title,
        //   style: GoogleFonts.poppins(
        //     fontSize: screenWidth(context) * 0.039,
        //     fontWeight: FontWeight.bold,
        //     color: primaryYatriGreenColor,
        //   ),
        // ),
        // SizedBox(height: screenHeight(context)*0.008),

        // TextFormField
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(screenHeight(context) * 0.01),
              child: Image.asset(assetPath, width: 20, height: 20),
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              color: primaryYatriGreenColor,
              fontSize: screenWidth(context) * 0.039,
            ),
            border: InputBorder.none,
          ),
        ),
      ],
    ),
  );
}

class CustomButton extends StatelessWidget {
  final double radius;
  final double height;
  final double width;
  final Color color;
  final String text;
  final Color textColor;
  const CustomButton({
    super.key,
    this.radius = 4,
    this.height = 0.054,
    this.width = 0.45,
    this.color = primaryYatriGreenColor,
    this.textColor = Colors.white,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenHeight(context)*height,
        width: screenWidth(context)*width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: SmallTextType(
          text: text,
          color: textColor,
        )
    );
  }
}

openErrorSnackBar(context, String text) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(text),
    duration: const Duration(milliseconds: 2500),
  ));
}