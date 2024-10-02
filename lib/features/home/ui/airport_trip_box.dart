import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatri_cabs_testapp/constants/dimensions.dart';
import 'package:yatri_cabs_testapp/constants/fonts.dart';
import '../../../constants/colors.dart';
import '../repo/HomeRepo.dart';
import '../widgets/widgets.dart';

final airportTabProvider = StateProvider<int>((ref) => 0);

class AirportTransferBox extends ConsumerWidget {
  final TextEditingController cityFieldController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController airportFieldController;

  const AirportTransferBox({
    required this.cityFieldController,
    required this.dateController,
    required this.timeController,
    required this.airportFieldController,
  });

  Future<void> _selectDate(BuildContext context) async {
    await HomeRepo.selectDate(context, dateController);
  }

  Future<void> _selectTime(BuildContext context) async {
    await HomeRepo.selectTime(context, timeController);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedTab = ref.watch(airportTabProvider);

    return Column(
      children: [
        SizedBox(height: screenHeight(context)*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                ref.read(airportTabProvider.notifier).state = 0;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight(context)* 0.001,
                  horizontal: screenWidth(context) * 0.05,
                ),
                decoration: BoxDecoration(
                  color: selectedTab == 0 ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: SmallTextType(
                  text: 'To The Airport',
                  color:selectedTab == 0 ? Colors.white : Colors.black,
                  weight:FontWeight.bold,
                  size: screenWidth(context)*0.039,
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            GestureDetector(
              onTap: () {
                ref.read(airportTabProvider.notifier).state = 1; // Set to "From The Airport"
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight(context)* 0.001,
                  horizontal: screenWidth(context)* 0.05,
                ),
                decoration: BoxDecoration(
                  color: selectedTab == 1 ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: SmallTextType(
                  text: 'From The Airport',
                  color:selectedTab == 1 ? Colors.white : Colors.black,
                  size: screenWidth(context)*0.039,
                  weight:FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight(context)*0.01),

        // Display form based on selected tab
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.33,
          child: selectedTab == 0
              ? _buildToAirportForm(context, 'Pick-up City', 'Type City Name')
              : _buildFromAirportForm(context, 'Pick-up Airport','Type City Name'),
        ),
      ],
    );
  }

  Widget _buildToAirportForm(BuildContext context, String label, String hintText) {
    return _buildForm(
      textFieldController: cityFieldController,
      dateController: dateController,
      timeController: timeController,
      context: context,
      label: label,
      hintText: hintText
    );
  }

  Widget _buildFromAirportForm(BuildContext context, String label, String hintText) {
    return _buildForm(
      textFieldController: airportFieldController,
      dateController: dateController,
      timeController: timeController,
      context: context,
      label: label,
        hintText: hintText
    );
  }

  Widget _buildForm({
    required TextEditingController textFieldController,
    required TextEditingController dateController,
    required TextEditingController timeController,
    required BuildContext context,
    required String label,
    required String hintText,
  }) {
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
          basicTextField(
            textFieldController,
            'assets/icons/location_icon.png',
            label,
            hintText,
            context
          ),
          SizedBox(height: screenHeight(context) * 0.01),
          _timePickerField(context, timeController),
          SizedBox(height: screenHeight(context)* 0.01),
          _datePickerField(context, dateController),
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
      onTap: () => _selectTime(context),
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
      onTap: () => _selectDate(context),
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
