import 'package:flutter/material.dart';
import 'package:geobound_web/widgets/text_widget.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Card(
                color: Colors.white,
                child: SizedBox(
                  height: 200,
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: '48',
                        fontSize: 75,
                        fontFamily: 'Bold',
                        color: Colors.green,
                      ),
                      TextWidget(
                        text: 'Number of Users',
                        fontSize: 17,
                        fontFamily: 'Regular',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Card(
                color: Colors.white,
                child: SizedBox(
                  height: 200,
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: '₱ 52,000',
                        fontSize: 50,
                        fontFamily: 'Bold',
                        color: Colors.green,
                      ),
                      TextWidget(
                        text: 'Total Bill Paid this Month',
                        fontSize: 17,
                        fontFamily: 'Regular',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          TextWidget(
            text: 'Monthly Water Usage',
            fontSize: 28,
            fontFamily: 'Bold',
            color: Colors.black,
          ),
          const Card(
            color: Colors.white,
            child: SizedBox(
              height: 350,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
