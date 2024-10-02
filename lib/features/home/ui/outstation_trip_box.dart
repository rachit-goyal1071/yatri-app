import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yatri_cabs_testapp/constants/colors.dart';

import '../../../constants/dimensions.dart';
import '../../../constants/fonts.dart';
import '../widgets/widgets.dart';

class OutstationTripBox extends ConsumerStatefulWidget {
  @override
  _OutstationTripBoxState createState() => _OutstationTripBoxState();
}

class _OutstationTripBoxState extends ConsumerState<OutstationTripBox> {
  int _selectedTripType = 0;

  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _textFieldController3 = TextEditingController();
  final TextEditingController _textFieldController4 = TextEditingController();
  final TextEditingController _secondTimeController = TextEditingController();
  final TextEditingController _secondDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenHeight(context)*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTripType = 0;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight(context)*0.001, horizontal: screenWidth(context)*0.05),
                decoration: BoxDecoration(
                  color: _selectedTripType == 0 ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: SmallTextType(
                  text: 'One-Way',
                  color: _selectedTripType == 0 ? Colors.white : Colors.black,
                  weight: FontWeight.bold,
                  size: screenWidth(context)*0.039,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTripType = 1;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight(context)*0.001, horizontal: screenWidth(context)*0.05),
                decoration: BoxDecoration(
                  color: _selectedTripType == 1 ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: SmallTextType(
                  text: 'Round Trip',
                  color: _selectedTripType == 1 ? Colors.white : Colors.black,
                  weight: FontWeight.bold,
                  size: screenWidth(context)*0.039,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight(context)*0.01),

        SizedBox(
          height: screenHeight(context) * 0.41, // Adjust height for form
          child: _selectedTripType == 0
              ? _buildFirstForm()  // First form for One-Way
              : _buildSecondForm(), // Second form for Round Trip
        ),
      ],
    );
  }

  Widget _buildFirstForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          basicTextField(_textFieldController1, 'assets/icons/location_icon.png', 'Pick-up City','Enter City Name',context),
          SizedBox(height: screenHeight(context)*0.01,),
          basicTextField(_textFieldController2, 'assets/icons/flag_icon.png', 'Drop City','Enter City Name',context),
          SizedBox(height: screenHeight(context)*0.01,),
          datePickerField(context, _dateController),
          SizedBox(height: screenHeight(context)*0.01,),
          timePickerField(context, _timeController),
          SizedBox(height: screenHeight(context)*0.01,),
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

  Widget _buildSecondForm() {
    return Container(
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
          basicTextField(_textFieldController3, 'assets/icons/location_icon.png', 'Pick-up City','Type City Name',context),
          SizedBox(height: screenHeight(context)*0.01,),
          basicTextField(_textFieldController4, 'assets/icons/flag_icon.png', 'Drop City','Type City Name',context),
          SizedBox(height: screenHeight(context)*0.01,),
          timePickerField(context, _secondTimeController),
          SizedBox(height: screenHeight(context)*0.01,),
          datePickerField(context, _secondDateController),
          SizedBox(height: screenHeight(context)*0.01,),
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

  Widget timePickerField(BuildContext context, TextEditingController controller) {
    return GestureDetector(
      onTap: () => _selectTime(context, controller),
      child: AbsorbPointer(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // border: Border.all(color: Colors.grey),
              boxShadow: kElevationToShadow[1],
              color: secondaryYatriGreenColor
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

  Widget datePickerField(BuildContext context, TextEditingController controller) {
    return GestureDetector(
      onTap: () => _selectDate(context, controller),
      child: AbsorbPointer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: Colors.grey),
              boxShadow: kElevationToShadow[1],
            color: secondaryYatriGreenColor
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
