import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimensions.dart';
import '../repo/HomeRepo.dart';
import '../widgets/widgets.dart';

class LocalTripBox extends StatefulWidget {
  final TextEditingController textFieldController;
  final TextEditingController dateController;
  final TextEditingController timeController;

  LocalTripBox({
    required this.textFieldController,
    required this.dateController,
    required this.timeController,
  });

  @override
  State<LocalTripBox> createState() => _LocalTripBoxState();
}

class _LocalTripBoxState extends State<LocalTripBox> {

  Future<void> _selectDate() async {
    await HomeRepo.selectDate(context, widget.dateController);
    setState(() {});
  }
  Future<void> _selectTime() async {
    await HomeRepo.selectTime(context, widget.timeController);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight(context)*0.015),
      padding: EdgeInsets.all(screenWidth(context)*0.045),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          basicTextField(
            widget.textFieldController,
            'assets/icons/location_icon.png',
            'Pick-up City',
            'Enter City Name',
            context,
          ),
          SizedBox(height: screenHeight(context) * 0.01),
          _datePickerField(context, widget.dateController),
          SizedBox(height: screenHeight(context) * 0.01),
          _timePickerField(context, widget.timeController),
          SizedBox(height: screenHeight(context) * 0.01),
          GestureDetector(
            onTap: (){
              openErrorSnackBar(context, 'No Data');
            },
            child: const CustomButton(
                radius: 20,
                text: 'Explore Cabs'),
          )
        ],
      ),
    );
  }

  Widget _timePickerField(BuildContext context, TextEditingController controller) {
    return GestureDetector(
      onTap: () => _selectTime(),
      child: AbsorbPointer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: Colors.grey),
            boxShadow: kElevationToShadow[1],
            color: secondaryYatriGreenColor,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(screenHeight(context)*0.01),
                child: Image.asset('assets/icons/time_icon.png', width: 20, height: 20),
              ),
              hintText: 'Time',
              hintStyle: GoogleFonts.poppins(
                color: primaryYatriGreenColor,
                fontSize: screenWidth(context)*0.039
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _datePickerField(BuildContext context, TextEditingController controller) {
    return GestureDetector(
      onTap: () => _selectDate(),
      child: AbsorbPointer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: Colors.grey),
            boxShadow: kElevationToShadow[1],
            color: secondaryYatriGreenColor,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(screenHeight(context)*0.01),
                child: Image.asset('assets/icons/date_icon.png', width: 20, height: 20),
              ),
              hintText: 'Pick-up Date',
              hintStyle: GoogleFonts.poppins(
                  color: primaryYatriGreenColor,
                  fontSize: screenWidth(context)*0.039
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
