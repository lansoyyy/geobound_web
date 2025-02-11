import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/utils/const.dart';
import 'package:geobound_web/widgets/text_widget.dart';
import 'package:latlong2/latlong.dart';

class FourthTab extends StatelessWidget {
  const FourthTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
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
          return StreamBuilder<QuerySnapshot>(
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

                final vehicleData = snapshot.requireData;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 750,
                        height: 450,
                        child: Stack(
                          children: [
                            FlutterMap(
                              options: const MapOptions(
                                initialCenter: LatLng(8.486308,
                                    124.657486), // Center the map over London
                                initialZoom: 18,
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
                                      point: LatLng(data.docs[i]['lat'],
                                          data.docs[i]['lng']),
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: TextWidget(
                                            text:
                                                '${data.docs[i]['name'][0]}${data.docs[i]['name'][1]}${data.docs[i]['name'][2]}',
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontFamily: 'Bold',
                                          ),
                                        ),
                                      ),
                                    ),
                                  for (int i = 0;
                                      i < vehicleData.docs.length;
                                      i++)
                                    Marker(
                                      width: 50,
                                      point: LatLng(vehicleData.docs[i]['lat'],
                                          vehicleData.docs[i]['long']),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Center(
                                          child: TextWidget(
                                            text:
                                                '${vehicleData.docs[i]['platenumber']}',
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontFamily: 'Bold',
                                          ),
                                        ),
                                      ),
                                    ),
                                ]),
                                PolygonLayer(
                                  polygons: [
                                    Polygon(
                                        points: [
                                          const LatLng(8.486484, 124.657151),
                                          const LatLng(8.486279, 124.657089),
                                          const LatLng(8.485970, 124.657461),
                                          const LatLng(8.486062, 124.657685),
                                          const LatLng(8.486341, 124.657471),
                                          const LatLng(8.486487, 124.657163),
                                          const LatLng(8.486484, 124.657151),
                                        ],
                                        color: Colors.red.withOpacity(0.2),
                                        borderColor: Colors.black,
                                        borderStrokeWidth: 2,
                                        isFilled: true),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 180,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: 'Map Legend',
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Bold',
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 15,
                                              height: 15,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            TextWidget(
                                              text: 'Personnel',
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontFamily: 'Medium',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 15,
                                              height: 15,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            TextWidget(
                                              text: 'Vehicles',
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontFamily: 'Medium',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 15,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                shape: BoxShape.rectangle,
                                                color:
                                                    Colors.red.withOpacity(0.2),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            TextWidget(
                                              text: 'Geofencing Area',
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontFamily: 'Medium',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                // DataColumn(
                                //   label: TextWidget(
                                //     text: 'Date and Time',
                                //     fontSize: 18,
                                //     fontFamily: 'Bold',
                                //     color: primary,
                                //   ),
                                // ),
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
                                    // DataCell(
                                    //   TextWidget(
                                    //     text: DateFormat('yyyy-MM-dd')
                                    //         .format(DateTime.now()),
                                    //     fontSize: 14,
                                    //     fontFamily: 'Medium',
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                    DataCell(
                                      Builder(builder: (context) {
                                        LatLng pointToCheck = LatLng(
                                            data.docs[i]['lat'],
                                            data.docs[i]['lng']);
                                        final bool isInside = isPointInPolygon(
                                            pointToCheck, polygon);

                                        return TextWidget(
                                          text: isInside
                                              ? 'Present'
                                              : 'Not Present',
                                          fontSize: 14,
                                          fontFamily: 'Medium',
                                          color: Colors.grey,
                                        );
                                      }),
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
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('Users')
                                              .where('id',
                                                  isEqualTo: data.docs[i]
                                                      ['userId'])
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasError) {
                                              print(snapshot.error);
                                              return const Center(
                                                  child: Text('Error'));
                                            }
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 50),
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: Colors.black,
                                                )),
                                              );
                                            }

                                            final recordData =
                                                snapshot.requireData;
                                            return Builder(builder: (context) {
                                              LatLng pointToCheck = LatLng(
                                                  recordData.docs.first['lat'],
                                                  recordData.docs.first['lng']);
                                              final bool isInside =
                                                  isPointInPolygon(
                                                      pointToCheck, polygon);

                                              return TextWidget(
                                                text: isInside
                                                    ? 'Present'
                                                    : 'Not Present',
                                                fontSize: 14,
                                                fontFamily: 'Medium',
                                                color: Colors.grey,
                                              );
                                            });
                                          }),
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
