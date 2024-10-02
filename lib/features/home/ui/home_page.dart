import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatri_cabs_testapp/constants/colors.dart';
import 'package:yatri_cabs_testapp/constants/fonts.dart';
import 'package:yatri_cabs_testapp/features/home/ui/airport_trip_box.dart';
import 'package:yatri_cabs_testapp/features/home/ui/local_trip_box.dart';
import 'package:yatri_cabs_testapp/features/home/ui/outstation_trip_box.dart';

import '../../../constants/dimensions.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});


  final selectedIndexProvider = StateProvider<int>((ref) => 0);
  final TextEditingController cityController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController airportController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List<Image> iconsList = [
      Image.asset('assets/icons/map_icon.png',height: 50,color: Colors.black,),
      Image.asset('assets/icons/train_icon.png',height: 50,color: Colors.black,),
      Image.asset('assets/icons/flite_icon.png',height: 50,color: Colors.black,)
    ];
    final currentIndex = ref.watch(selectedIndexProvider);
    final List<String> labelList = ['Outstation Trip', 'Local Trip', 'Airport Trip'];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth(context)*0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/img/logo_yatri.png'),
                    const Icon(Icons.notifications_active,color: Colors.white,)
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight(context)*0.003),
                  child: RichText(text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "India's Leading",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: screenWidth(context)*0.06,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: " Inter-City\nOne Way",
                        style: GoogleFonts.poppins(
                          color: primaryYatriGreenColor,
                          fontSize: screenWidth(context)*0.06,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: " Cab Service Provider",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: screenWidth(context)*0.06,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]
                  )),
                ),
                SizedBox(
                  height: screenHeight(context)*0.18,
                  child: Swiper(
                    itemCount: 4,
                    scale: 0.9,
                    itemBuilder:(context, index) {
                      return Container(
                        child: Image.asset('assets/img/cab_image.png'),
                      );
                    },
                    index: 0,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.black, // Color of inactive dots
                        activeColor: primaryYatriGreenColor, // Color of active dot
                        size: 10.0, // Size of inactive dots
                        activeSize: 12.0, // Size of the active dot
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: screenWidth(context),
                  height: screenHeight(context)*0.09,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          ref.read(selectedIndexProvider.notifier).state = index;
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: screenWidth(context)*0.005),
                          height: screenHeight(context)*0.05,
                          width: screenWidth(context)*0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: currentIndex == index? primaryYatriGreenColor:Colors.white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      currentIndex == index? Colors.white:Colors.black,
                                      BlendMode.srcIn,
                                  ),
                                child: iconsList[index],
                              ),
                              SmallTextType(
                                text: labelList[index],
                                size: 10,
                                color: currentIndex == index? Colors.white:Colors.black,)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: currentIndex == 0
                      ? OutstationTripBox()
                      : currentIndex == 1
                      ? LocalTripBox(
                      textFieldController: cityController,
                      dateController: dateController,
                      timeController: timeController,
                  )
                      : AirportTransferBox(
                      cityFieldController: cityController,
                      dateController: dateController,
                      timeController: timeController,
                      airportFieldController: airportController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight(context)*0.01),
                  child: Image.asset('assets/img/last_image.png'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
