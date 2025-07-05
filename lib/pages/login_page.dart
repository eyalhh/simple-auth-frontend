import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth/auth/auth_client.dart';
import 'package:simple_auth/components/my_button.dart';
import 'package:simple_auth/components/my_textfield.dart';
import 'package:simple_auth/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool? isLogged;

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
                  'Welcome back to Simple Auth! we missed you.',
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
              isLogged != null && isLogged == false
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'One or more credintials are missing/incorrect',
                        style: TextStyle(color: Colors.red, fontSize: 16),
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
                  int statusCode = await authClient.login(
                    emailController.text,
                    passwordController.text,
                  );

                  if (statusCode == 200) {
                    if (mounted) {
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                    return;
                  }
                  if (mounted) {
                    setState(() {
                      isLogged = statusCode == 200;
                    });
                  }
                },
                text: "Sign In",
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
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed('/signup'),
                    },
                    child: Text(
                      'Register now',
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
