import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geobound_web/screens/auth/login_screen.dart';
import 'package:geobound_web/screens/tabs/first_tab.dart';
import 'package:geobound_web/screens/tabs/fourth_tab.dart';
import 'package:geobound_web/screens/tabs/report_tab.dart';
import 'package:geobound_web/screens/tabs/second_tab.dart';
import 'package:geobound_web/screens/tabs/third_tab.dart';
import 'package:geobound_web/services/add_user.dart';
import 'package:geobound_web/services/add_vehicle.dart';
import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/widgets/logout_widget.dart';
import 'package:geobound_web/widgets/text_widget.dart';
import 'package:geobound_web/widgets/toast_widget.dart';

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
      floatingActionButton: index == 1 || index == 0
          ? FloatingActionButton(
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                if (index == 0) {
                  createDialog1(false);
                } else {
                  createDialog(false);
                }
              },
            )
          : null,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 5),
                        child: Card(
                          color: Colors.white,
                          child: SizedBox(
                            width: 200,
                            child: ListTile(
                              onTap: () {
                                logout(context, const LoginScreen());
                              },
                              title: TextWidget(
                                text: 'Logout',
                                fontSize: 18,
                                fontFamily: 'Bold',
                                color: Colors.black,
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
                  children: const [
                    FirstTab(),
                    SecondTab(),
                    ThirdTab(),
                    FourthTab(),
                    ReportTab(),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  final TextEditingController model = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController platenumber = TextEditingController();

  String? selectedValue;

  String userId = '';

  createDialog(bool inUpdate) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Vehicle'),
          content: StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(child: Text('Error'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                          );
                        }

                        final data = snapshot.requireData;
                        return DropdownButton<String>(
                          value: selectedValue,
                          hint: const Text('Select the personnel'),
                          icon: const Icon(Icons.arrow_drop_down),
                          items: [
                            for (int i = 0; i < data.docs.length; i++)
                              DropdownMenuItem(
                                value: data.docs[i].id,
                                child: TextWidget(
                                  text: data.docs[i]['name'],
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  setState(() {
                                    userId = data.docs[i].id;
                                  });
                                },
                              ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue;
                            });
                          },
                        );
                      }),
                  const SizedBox(height: 10),
                  TextField(
                    controller: model,
                    decoration: const InputDecoration(
                      labelText: 'Vehicle Model',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: color,
                    decoration: const InputDecoration(
                      labelText: 'Color',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: platenumber,
                    decoration: const InputDecoration(
                      labelText: 'Plate Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (userId != '') {
                  addVehicle(model.text, color.text, platenumber.text, userId);
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  showToast('Please select the personnel!');
                }
                // Handle saving the new employee's information here
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController fullnameController = TextEditingController();

  final TextEditingController rfidController = TextEditingController();

  final TextEditingController contactController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController sectorController = TextEditingController();

  createDialog1(bool inUpdate) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              inUpdate ? 'Update Employee Details' : 'Create New Employee'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: fullnameController,
                  decoration: const InputDecoration(
                    labelText: 'Fullname',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: rfidController,
                  decoration: const InputDecoration(
                    labelText: 'ID Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: contactController,
                  decoration: const InputDecoration(
                    labelText: 'Contact No.',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: sectorController,
                  decoration: const InputDecoration(
                    labelText: 'Assigned Sector',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // await FirebaseFirestore.instance
                //     .collection('Users')
                //     .doc(data.id)
                //     .update({
                //   'name': fullnameController.text,
                //   'number': contactController.text,
                //   'address': addressController.text,
                //   'id': rfidController.text,
                //   'sector': sectorController.text
                // });
                // // Handle saving the new employee's information here
                addUser(
                    fullnameController.text,
                    contactController.text,
                    rfidController.text,
                    addressController.text,
                    sectorController.text,
                    '',
                    'Personnel');
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
