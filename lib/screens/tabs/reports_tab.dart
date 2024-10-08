import 'package:flutter/material.dart';
import 'package:geobound_web/widgets/text_widget.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  List columns = [
    'Billing ID',
    'Meter ID',
    'Customer Name',
    'Baranggay',
    'Total Payment',
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
