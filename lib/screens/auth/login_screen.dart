import 'package:geobound_web/screens/home_screen.dart';
import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/widgets/button_widget.dart';
import 'package:geobound_web/widgets/text_widget.dart';
import 'package:geobound_web/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool inLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: 'Admin Account',
              fontSize: 18,
              fontFamily: 'Bold',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              height: 45,
              color: Colors.white,
              borderColor: Colors.white,
              label: 'Admin ID',
              controller: username,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              height: 45,
              color: Colors.white,
              borderColor: Colors.white,
              label: 'Password',
              showEye: true,
              isObscure: true,
              controller: password,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              color: Colors.amber,
              width: 150,
              radius: 10,
              label: 'Login',
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
