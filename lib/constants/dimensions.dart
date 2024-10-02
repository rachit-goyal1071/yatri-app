import 'package:flutter/cupertino.dart';

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// font 10 pixel = getScreenWidth(context)*0.028;
// font 12 pixel = getScreenWidth(context)*0.032;
// font 14 pixel = getScreenWidth(context)*0.039;
// font 18 pixel = getScreenWidth(context)*0.05;
// font 20 pixel = getScreenWidth(context)*0.0555;
// font 24 pixel = getScreenWidth(context)*0.065;