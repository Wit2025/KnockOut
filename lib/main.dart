import 'package:flutter/material.dart';
import 'package:knockout/Log/forgotPwd.dart';
import 'package:knockout/Screens/ServiceSelectionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:knockout/Log/LoginPage.dart';
import 'package:knockout/Screens/Home.dart';
import 'package:knockout/Screens/WellcomePage.dart';
import 'package:knockout/Screens/HistoryPage.dart';
import 'package:knockout/Screens/Profile/ProfilePage.dart';
import 'package:knockout/Screens/ScanQRCodePage.dart';
import 'package:knockout/Screens/TrackingPage.dart';
import 'package:knockout/Screens/WalletPage.dart';
import 'package:knockout/Log/RegisterPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(HelmetCareApp(initialRoute: isLoggedIn ? '/home' : '/'));
}

class HelmetCareApp extends StatelessWidget {
  final String initialRoute;
  const HelmetCareApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Knock Out',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
      ),
      initialRoute: initialRoute, // ใช้ route ตามสถานะ login
      routes: {
        '/': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/wallet': (context) => const WalletPage(),
        '/scan': (context) => const QRScannerScreen(),
        '/services': (context) => const ServiceSelectionPage(),
        // '/summary': (context) => const OrderSummaryPage(),
        '/tracking': (context) => const RealtimeTrackingPage(),
        '/history': (context) => const HistoryPage(),
        '/profile': (context) => ProfilePage(),
        '/home': (context) => Home(),
        '/forgot': (context) => ForgotPasswordPage(),
      },
    );
  }
}
