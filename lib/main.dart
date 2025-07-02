import 'package:flutter/material.dart';
import 'package:simple_auth/pages/email_validate_page.dart';
import 'package:simple_auth/pages/login_page.dart';
import 'package:simple_auth/pages/signup_page.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  late List<Widget> pages;

  void goToLogin() {
    setState(() {
      index = 0;
    });
  }

  void goToSignup() {
    setState(() {
      index = 1;
    });
  }

  void onTap(BuildContext context) {
    Navigator.of(context).pushNamed('/email-validation');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      LoginPage(goToSignup: goToSignup, onTap: onTap),
      SignupPage(goToLogin: goToLogin, onTap: onTap),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/email-validation': (context) => EmailValidatePage()},
      home: pages[index],
    );
  }
}
