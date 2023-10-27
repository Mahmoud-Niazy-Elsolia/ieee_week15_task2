import 'package:flutter/material.dart';
import 'package:ieee_week15_task2/db/sqflite_db.dart';
import 'package:ieee_week15_task2/models/contact_model.dart';
import 'package:ieee_week15_task2/widgets/bottom_sheet.dart';
import 'package:ieee_week15_task2/widgets/contact_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Contacts',
        ),
      ),
      body: FutureBuilder(
        future: SqfliteDb().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              children: snapshot.data!.map(
                (contact) => ContactItem(contact: ContactModel.fromJson(contact as Map<String,dynamic>),),
              ).toList(),
            );
          } else if (snapshot.hasError) {
            return const Text('ERROR');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: CustomBottomSheet(),
    );
  }
}
