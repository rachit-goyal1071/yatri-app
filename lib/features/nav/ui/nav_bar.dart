import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:yatri_cabs_testapp/constants/colors.dart';

import '../../home/ui/home_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  final bottomNavBarController = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }
    List<Widget> buildScreens(context) {
      return [
        HomePage(),
        HomePage(),
        HomePage(),
        HomePage(),
      ];
    }
    return Scaffold(
      body: Center(
        child: buildScreens(context).elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/home_icon.png',color: Colors.white,width: 20,),
              activeIcon: Image.asset('assets/icons/home_icon.png',width: 20),
              label: ('Home'),
              backgroundColor: primaryYatriGreenColor
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/trip_icon.png',color: Colors.white,width: 20,),
            activeIcon: Image.asset('assets/icons/trip_icon.png',width: 20),
            label: ('My Trip'),
              backgroundColor: primaryYatriGreenColor
          ),
          BottomNavigationBarItem(
              activeIcon: Image.asset('assets/icons/profile_icon.png',width: 20),
              label: ('Account'),
              icon: Image.asset('assets/icons/profile_icon.png',color: Colors.white,width: 20,),
              backgroundColor: primaryYatriGreenColor
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/more_icon.png',color: Colors.white,width: 20,),
            activeIcon:Image.asset('assets/icons/more_icon.png',width: 20),
            label: ('More'),
              backgroundColor: primaryYatriGreenColor
          ),
        ],
        iconSize: 0.1,
        backgroundColor: primaryYatriGreenColor,
        unselectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        onTap: onItemTapped,
      ),
    );
  }
}
