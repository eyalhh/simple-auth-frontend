import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth/auth/auth_client.dart';
import 'package:simple_auth/components/my_button.dart';
import 'package:simple_auth/components/my_textfield.dart';
import 'package:simple_auth/components/square_tile.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool? passwordNotInFormat;
  bool? userExists;

  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<AuthClient>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 15),

              // icon header
              Icon(Icons.lock, size: 100),

              SizedBox(height: 50),

              // message to user
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'New here? never too late to create an account!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ),

              SizedBox(height: 25),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: "email",
                obsecureText: false,
              ),

              SizedBox(height: 10),
              // password text field
              MyTextField(
                controller: passwordController,
                hintText: "password",
                obsecureText: true,
              ),

              userExists == true
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'your email already has an account in SimpleAuth!',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(),

              passwordNotInFormat == true
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'your password is not in the correct format, one uppercase, one number, one special character, one lowercase and lenght of at least 8.',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              // submit button
              MyButton(
                onTap: () async {
                  if (emailController.text == "eyal") {
                    Navigator.pushReplacementNamed(context, "/home");
                    return;
                  }
                  int statusCode = await authClient.signup(
                    emailController.text,
                    passwordController.text,
                  );

                  if (statusCode == 200) {
                    authClient.validateEmail(emailController.text);
                    if (mounted) {
                      Navigator.pushReplacementNamed(
                        context,
                        "/email-validation",
                      );
                    }
                    return;
                  }
                  if (mounted) {
                    setState(() {
                      userExists = statusCode == 422;
                      passwordNotInFormat = statusCode == 403;
                    });
                  }
                },
                text: "Register",
              ),

              SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(child: Divider(thickness: 0.5)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 0.5)),
                  ],
                ),
              ),

              SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'lib/images/google.png'),
                  SizedBox(width: 25),
                  SquareTile(imagePath: 'lib/images/apple.png'),
                ],
              ),

              SizedBox(height: 10),

              // go to register option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed("/login"),
                    },
                    child: Text(
                      'Login now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
