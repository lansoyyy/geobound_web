import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/widgets/text_widget.dart';

class ThirdTab extends StatefulWidget {
  const ThirdTab({super.key});

  @override
  State<ThirdTab> createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  String? selectedRole; // This will hold the selected value

  bool hasLoaded = false;

  List users = [];

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  getAllUsers() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          users.add(doc.data());
        });
      }
    });

    setState(() {
      hasLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return hasLoaded
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Logged Entry/Exit Status',
                  fontSize: 24,
                  color: primary,
                  fontFamily: 'Bold',
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<DatabaseEvent>(
                    stream: FirebaseDatabase.instance.ref("rfid_data").onValue,
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot.hasError) {
                        return const Center(child: Text('Error'));
                      }
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   final data = snapshot.data!.snapshot.value!;
                      //   print('data here $data');
                      //   return const Center(child: CircularProgressIndicator());
                      // }

                      if (snapshot.hasData) {
                        final data = snapshot.data!.snapshot.value!;

                        print('data here $data');

                        // Convert dynamic data to a list of maps
                        if (data != {}) {
                          final Map<dynamic, dynamic> dataMap =
                              data as Map<dynamic, dynamic>;
                          final List<Map<String, dynamic>> itemList =
                              dataMap.values.map((innerValue) {
                            return {
                              "Date": innerValue["Date"],
                              "ID": innerValue["ID"],
                              "Timestamp": innerValue["Timestamp"],
                            };
                          }).toList();
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 1), // Outer border
                            ),
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Personnel ID Number',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Name',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Entry Time',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Exit Time',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                              ],
                              rows: [
                                for (int i = 0; i < data.length; i++)
                                  DataRow(cells: [
                                    DataCell(
                                      TextWidget(
                                        text: itemList[i]['ID'].toString(),
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: users.where(
                                          (element) {
                                            return element['id'] ==
                                                itemList[i]['ID'].toString();
                                          },
                                        ).isNotEmpty
                                            ? users.where(
                                                (element) {
                                                  return element['id'] ==
                                                      itemList[i]['ID']
                                                          .toString();
                                                },
                                              ).first['name']
                                            : '',
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: itemList[i]['Timestamp']
                                                    .toString()
                                                    .split(' ')[1] ==
                                                'PM'
                                            ? ''
                                            : itemList[i]['Timestamp'] ?? '',
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: itemList[i]['Timestamp']
                                                    .toString()
                                                    .split(' ')[1] !=
                                                'PM'
                                            ? ''
                                            : itemList[i]['Timestamp'] ?? '',
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ])
                              ],
                              // DataTable's properties to add inner horizontal and vertical dividers
                              dividerThickness:
                                  1, // Horizontal dividers between rows
                              border: const TableBorder(
                                horizontalInside: BorderSide(
                                    color: Colors.grey,
                                    width: 1), // Horizontal dividers
                                verticalInside: BorderSide(
                                    color: Colors.grey,
                                    width: 1), // Vertical dividers
                              ),
                            ),
                          );
                        }
                      }
                      return const Center(child: Text('No data found'));
                    })
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
