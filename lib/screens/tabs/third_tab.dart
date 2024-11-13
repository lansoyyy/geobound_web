import 'package:flutter/material.dart';
import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/widgets/button_widget.dart';
import 'package:geobound_web/widgets/text_widget.dart';

class ThirdTab extends StatelessWidget {
  const ThirdTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1), // Outer border
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
                    color: Colors.grey, width: 1), // Horizontal dividers
                verticalInside: BorderSide(
                    color: Colors.grey, width: 1), // Vertical dividers
              ),
            ),
          )
        ],
      ),
    );
  }
}
