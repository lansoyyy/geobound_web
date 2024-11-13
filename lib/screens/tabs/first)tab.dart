import 'package:flutter/material.dart';
import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/widgets/button_widget.dart';
import 'package:geobound_web/widgets/text_widget.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextWidget(
            text: 'Numbers of Personnel Inside the Area:',
            fontSize: 24,
            color: primary,
            fontFamily: 'Bold',
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonWidget(
            radius: 5,
            fontSize: 24,
            color: primary!,
            textColor: Colors.white,
            label: '28',
            onPressed: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          for (int i = 0; i < 5; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: 'Personnel ID and Information',
                  fontSize: 18,
                  color: primary,
                ),
                Divider(
                  color: primary,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
