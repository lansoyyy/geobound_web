import 'package:geobound_web/screens/auth/login_screen.dart';
import 'package:geobound_web/screens/tabs/dashboard_tab.dart';
import 'package:geobound_web/screens/tabs/reports_tab.dart';
import 'package:geobound_web/screens/tabs/users_tab.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(
                width: 20,
              ),
              TextWidget(
                text: 'Luwasa Admin',
                fontSize: 32,
                fontFamily: 'Bold',
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              width: 400,
              height: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        leading: Icon(
                          Icons.dashboard_outlined,
                          color: index == 0 ? Colors.black : Colors.grey,
                        ),
                        title: TextWidget(
                          text: 'Dashboard',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: index == 0 ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        leading: Icon(
                          Icons.groups_2_outlined,
                          color: index == 1 ? Colors.black : Colors.grey,
                        ),
                        title: TextWidget(
                          text: 'Users',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: index == 1 ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        leading: Icon(
                          Icons.insert_chart_sharp,
                          color: index == 2 ? Colors.black : Colors.grey,
                        ),
                        title: TextWidget(
                          text: 'Reports',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: index == 2 ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        onTap: () {
                          logout(context, const LoginScreen());
                        },
                        leading: const Icon(
                          Icons.logout_outlined,
                          color: Colors.red,
                        ),
                        title: TextWidget(
                          text: 'Logout',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey[100],
              child: IndexedStack(
                index: index,
                children: const [
                  DashboardTab(),
                  UsersTab(),
                  ReportsTab(),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
