import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/widgets/text_widget.dart';
import 'package:latlong2/latlong.dart';

class FourthTab extends StatelessWidget {
  const FourthTab({super.key});

  @override
  Widget build(BuildContext context) {
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
                initialCenter:
                    LatLng(51.509364, -0.128928), // Center the map over London
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  // Display map tiles from any source
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                  userAgentPackageName: 'com.example.app',
                  // And many more recommended properties!
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
                      showDetailDialog(context);
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
  }

  showDetailDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 450,
            width: 680,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                        for (int i = 0; i < 5; i++)
                          DataRow(cells: [
                            DataCell(
                              TextWidget(
                                text: '${i + 1}. Data here',
                                fontSize: 14,
                                fontFamily: 'Medium',
                                color: Colors.grey,
                              ),
                            ),
                            DataCell(
                              TextWidget(
                                text: 'Data here',
                                fontSize: 14,
                                fontFamily: 'Medium',
                                color: Colors.grey,
                              ),
                            ),
                            DataCell(
                              TextWidget(
                                text: 'Data here',
                                fontSize: 14,
                                fontFamily: 'Medium',
                                color: Colors.grey,
                              ),
                            ),
                            DataCell(
                              TextWidget(
                                text: 'Data here',
                                fontSize: 14,
                                fontFamily: 'Medium',
                                color: Colors.grey,
                              ),
                            ),
                          ])
                      ],
                      // DataTable's properties to add inner horizontal and vertical dividers
                      dividerThickness: 1, // Horizontal dividers between rows
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                            color: Colors.grey,
                            width: 1), // Horizontal dividers
                        verticalInside: BorderSide(
                            color: Colors.grey, width: 1), // Vertical dividers
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
