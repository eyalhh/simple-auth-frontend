import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth/auth/auth_client.dart';
import 'package:simple_auth/components/my_button.dart';
import 'package:simple_auth/components/my_textfield.dart';
import 'package:simple_auth/pages/home_page.dart';

class EmailValidatePage extends StatefulWidget {
  const EmailValidatePage({super.key});

  @override
  State<EmailValidatePage> createState() => _EmailValidatePageState();
}

class _EmailValidatePageState extends State<EmailValidatePage> {
  final TextEditingController codeController = TextEditingController();
  bool? codeCorrect;

  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<AuthClient>(context, listen: false);
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

                codeCorrect == false
                    ? Text(
                        "this code is incorrect.",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      )
                    : Container(),

                const SizedBox(height: 15),

                MyButton(
                  onTap: () async {
                    final user = await authClient.getUser();
                    final result = await authClient.verifyEmail(
                      user.email,
                      codeController.text,
                    );
                    if (result && mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                      );
                      return;
                    }
                    if (mounted) {
                      setState(() {
                        codeCorrect = false;
                      });
                    }
                  },
                  text: "Verify Email",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
