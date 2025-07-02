import 'package:flutter/material.dart';
import 'package:simple_auth/components/my_button.dart';
import 'package:simple_auth/components/my_textfield.dart';

class EmailValidatePage extends StatefulWidget {
  const EmailValidatePage({super.key});

  @override
  State<EmailValidatePage> createState() => _EmailValidatePageState();
}

class _EmailValidatePageState extends State<EmailValidatePage> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verify Your Email",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'We sent a verification code to your email. pls submit it here.',
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 50),

                MyTextField(
                  controller: codeController,
                  hintText: 'code',
                  obsecureText: false,
                ),

                const SizedBox(height: 15),

                MyButton(onTap: () {}, text: "Verify Email"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
