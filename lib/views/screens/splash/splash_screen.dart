import 'package:flutter/material.dart';
import 'package:google_sheet_task/views/shared/utils/colors.dart';
import 'package:google_sheet_task/views/shared/utils/images.dart';
import 'package:google_sheet_task/views/shared/utils/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0.0;
  double loaderProgressValue = 0.05;

  Future<void> changeLogoOpacity() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      opacity = 1.0;
    });
  }

  Future<void> changeLoaderValue() async {
    await Future.delayed(Duration(milliseconds: 2500));
    setState(() {
      loaderProgressValue = 1.0;
    });
    await Future.delayed(Duration(milliseconds: 3500));
    AppRouter.pushReplacementNamed(AppRoutes.landing);
  }

  @override
  void initState() {
    super.initState();
    changeLogoOpacity();
    changeLoaderValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            duration: Duration(milliseconds: 2500),
            opacity: opacity,
            child: Center(
              child: Image.asset(
                AppImages.appLogo ?? 'assets/images/logo.jpg',
                height: 250,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Stack(
              children: [
                Container(
                  height: 4,
                  color: AppColors.secondaryColor,
                  width: MediaQuery.of(context).size.width,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 3500),
                  height: 4,
                  color: AppColors.primaryColor,
                  width:
                      MediaQuery.of(context).size.width * loaderProgressValue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
