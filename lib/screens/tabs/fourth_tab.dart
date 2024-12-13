import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/widgets/text_widget.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class FourthTab extends StatelessWidget {
  const FourthTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Vehicles').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          }

          final data = snapshot.requireData;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 750,
                  height: 450,
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(
                          8.485383, 124.655940), // Center the map over London
                      initialZoom: 16,
                    ),
                    children: [
                      TileLayer(
                        // Display map tiles from any source
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                        userAgentPackageName: 'com.example.app',
                        // And many more recommended properties!
                      ),
                      MarkerLayer(markers: [
                        for (int i = 0; i < data.docs.length; i++)
                          Marker(
                            point: LatLng(
                                data.docs[i]['lat'], data.docs[i]['long']),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: TextWidget(
                                  text: '${i + 1}',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Bold',
                                ),
                              ),
                            ),
                          ),
                      ])
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      color: Colors.amber,
                      child: SizedBox(
                        width: 200,
                        child: ListTile(
                          onTap: () {
                            showDetailDialog(context);
                          },
                          title: TextWidget(
                            text: 'Personnel',
                            fontSize: 18,
                            fontFamily: 'Bold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.amber,
                      child: SizedBox(
                        width: 200,
                        child: ListTile(
                          onTap: () {
                            showDetailDialog1(context);
                          },
                          title: TextWidget(
                            text: 'Vehicles',
                            fontSize: 18,
                            fontFamily: 'Bold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  showDetailDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return SizedBox(
                  height: 450,
                  width: 680,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Monitor Realtime Status',
                            fontSize: 24,
                            color: primary,
                            fontFamily: 'Bold',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 1), // Outer border
                            ),
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: TextWidget(
                                    text: 'ID Number',
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
                                    text: 'Date and Time',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Current Status',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                              ],
                              rows: [
                                for (int i = 0; i < data.docs.length; i++)
                                  DataRow(cells: [
                                    DataCell(
                                      TextWidget(
                                        text: data.docs[i]['id'],
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: data.docs[i]['name'],
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: DateFormat('yyyy-MM-dd')
                                            .format(DateTime.now()),
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: 'Present',
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
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  showDetailDialog1(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Vehicles').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return SizedBox(
                  height: 450,
                  width: 680,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Monitor Realtime Status',
                            fontSize: 24,
                            color: primary,
                            fontFamily: 'Bold',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 1), // Outer border
                            ),
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Personnel ID',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Model',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Plate Number',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Current Status',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ),
                              ],
                              rows: [
                                for (int i = 0; i < data.docs.length; i++)
                                  DataRow(cells: [
                                    DataCell(
                                      TextWidget(
                                        text: data.docs[i]['userId'],
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: data.docs[i]['model'],
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: data.docs[i]['platenumber'],
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DataCell(
                                      TextWidget(
                                        text: 'Standby',
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
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
