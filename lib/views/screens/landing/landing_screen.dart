import 'package:flutter/material.dart';
import 'package:google_sheet_task/views/screens/form/form_screen.dart';
import 'package:google_sheet_task/views/screens/list/list_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<Widget> screens = [
    ProductListScreen(),
    ProductFormScreen(),
  ];
  int currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      this.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this.currentIndex,
        onTap: (nextIndex) {
          changeIndex(nextIndex);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Form',
          ),
        ],
      ),
    );
  }
}
