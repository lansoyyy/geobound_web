import 'package:geobound_web/screens/auth/login_screen.dart';
import 'package:geobound_web/screens/tabs/first)tab.dart';
import 'package:geobound_web/screens/tabs/second_tab.dart';
import 'package:geobound_web/screens/tabs/third_tab.dart';

import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/widgets/logout_widget.dart';
import 'package:geobound_web/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  List items = [
    'Number of Personnel',
    'Vehicles',
    'Logged Entry/Exit',
    'Monitor\nRealtime Status',
    'Generate Reports'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 75),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 35,
              ),
              const Expanded(
                child: SizedBox(
                  width: 20,
                ),
              ),
              TextWidget(
                text: 'Admin',
                fontSize: 14,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Card(
          color: Colors.black26,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  width: 400,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      for (int i = 0; i < items.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Card(
                            color: Colors.amber,
                            child: SizedBox(
                              width: 200,
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    index = i;
                                  });
                                },
                                title: TextWidget(
                                  text: items[i],
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                  color:
                                      index == i ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                color: Colors.grey[100],
                child: IndexedStack(
                  index: index,
                  children: const [FirstTab(), SecondTab(), ThirdTab()],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
