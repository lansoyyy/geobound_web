import 'package:geobound_web/screens/home_screen.dart';
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
  final name = TextEditingController();
  final number = TextEditingController();

  bool inLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              opacity: 0.35,
              image: AssetImage(
                'assets/images/bg.jpg',
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            width: 1000,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Row(
              children: [
                inLogin ? login() : register(),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 630,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/illus2.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget login() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: SizedBox(
        height: double.infinity,
        width: 350,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 35,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextWidget(
                    text: 'Luwasa Admin Panel',
                    fontSize: 24,
                    fontFamily: 'Bold',
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Icon(
                Icons.account_circle,
                size: 75,
              ),
              TextWidget(
                text: 'Hi, Admin!',
                fontSize: 32,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                height: 25,
              ),
              TextFieldWidget(
                label: 'Username  ',
                controller: username,
              ),
              TextFieldWidget(
                isObscure: true,
                showEye: true,
                label: 'Password  ',
                controller: password,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWidget(
                      width: 150,
                      label: 'Login',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      },
                    ),
                    TextButton(
                      onPressed: () {},
                      child: TextWidget(
                        text: 'Forgot Password?',
                        fontSize: 14,
                        fontFamily: 'Bold',
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: 'No account yet?',
                    fontSize: 14,
                    fontFamily: 'Medium',
                    color: Colors.red,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        inLogin = false;
                      });
                    },
                    child: TextWidget(
                      text: 'Register here',
                      fontSize: 14,
                      fontFamily: 'Bold',
                      color: Colors.red,
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

  Widget register() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: SizedBox(
        height: double.infinity,
        width: 350,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.account_circle,
                size: 75,
              ),
              TextWidget(
                text: 'Create Account',
                fontSize: 32,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                label: 'Fullname  ',
                controller: name,
              ),
              TextFieldWidget(
                label: 'Contact Number  ',
                controller: number,
              ),
              TextFieldWidget(
                label: 'Username  ',
                controller: username,
              ),
              TextFieldWidget(
                isObscure: true,
                showEye: true,
                label: 'Password  ',
                controller: password,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonWidget(
                width: 300,
                label: 'Register',
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: 'Already have an account?',
                    fontSize: 14,
                    fontFamily: 'Medium',
                    color: Colors.red,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        inLogin = true;
                      });
                    },
                    child: TextWidget(
                      text: 'Login here',
                      fontSize: 14,
                      fontFamily: 'Bold',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
