import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geobound_web/utils/colors.dart';
import 'package:geobound_web/widgets/button_widget.dart';
import 'package:geobound_web/widgets/text_widget.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({super.key});

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
                  label: data.docs.length.toString(),
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < data.docs.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text:
                            'Name: ${data.docs[i]['name']},   Sector: ${data.docs[i]['sector']},  ID: ${data.docs[i]['id']}',
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
        });
  }
}
