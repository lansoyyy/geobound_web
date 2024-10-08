import 'package:flutter/material.dart';
import 'package:geobound_web/widgets/text_widget.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  List columns = [
    'Name',
    'House Number',
    'Baranggay',
    'Contact Number',
    'Meter ID'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: DataTable(columns: [
          for (int i = 0; i < columns.length; i++)
            DataColumn(
              label: TextWidget(
                text: columns[i],
                fontSize: 18,
                fontFamily: 'Bold',
              ),
            ),
        ], rows: [
          for (int i = 0; i < 10; i++)
            DataRow(cells: [
              for (int i = 0; i < columns.length; i++)
                DataCell(
                  TextWidget(
                    text: 'Data here',
                    fontSize: 16,
                    fontFamily: 'Medium',
                  ),
                )
            ])
        ]));
  }
}
