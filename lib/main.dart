import 'package:flutter/material.dart';
import 'package:google_sheet_task/locator.dart';
import 'package:google_sheet_task/views/shared/utils/colors.dart';
import 'package:google_sheet_task/views/shared/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServicesLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sheet Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: AppColors.primaryColor,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRoutes.initialRoute,
      navigatorKey: AppRouter.navKey,
    );
  }
}
