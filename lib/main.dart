import 'package:flutter/material.dart';
import 'package:simple_auth/auth/auth_client.dart';
import 'package:simple_auth/pages/email_validate_page.dart';
import 'package:simple_auth/pages/home_page.dart';
import 'package:simple_auth/pages/login_page.dart';
import 'package:simple_auth/pages/signup_page.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AuthClient(baseUrl: "http://192.168.1.39:8080"),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/email-validation': (context) => EmailValidatePage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/home': (context) => HomePage(),
        },
        home: SignupPage(),
      ),
    );
  }
}
