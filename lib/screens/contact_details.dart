import 'package:flutter/material.dart';
import 'package:ieee_week15_task2/components/custom_button.dart';
import 'package:ieee_week15_task2/components/custom_text_field.dart';
import 'package:ieee_week15_task2/db/sqflite_db.dart';
import 'package:ieee_week15_task2/models/contact_model.dart';
import 'package:ieee_week15_task2/screens/home_screen.dart';

import '../components/custom_text_button.dart';

class ContactDetails extends StatefulWidget {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController numberController = TextEditingController();
  static TextEditingController urlController = TextEditingController();

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();



  final ContactModel contact;

  const ContactDetails({
    super.key,
    required this.contact,
  });

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  void initState() {
    super.initState();
    ContactDetails.nameController.text = widget.contact.name;
    ContactDetails.numberController.text = widget.contact.number;
    ContactDetails.urlController.text = widget.contact.imageUrl;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: ContactDetails.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .4,
                    width: MediaQuery.of(context).size.width * .5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.contact.imageUrl,
                            ))),
                  ),
                ),
                CustomTextFormField(
                  label: 'name',
                  controller: ContactDetails.nameController,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return 'Name can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: 'number',
                  controller: ContactDetails.numberController,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return 'Number can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: 'Url',
                  controller: ContactDetails.urlController,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return 'Url can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  urlController: ContactDetails.urlController,
                  numberController: ContactDetails.numberController,
                  nameController: ContactDetails.nameController,
                  onPressed: () async {
                    if (ContactDetails.formKey.currentState!.validate()) {
                      await SqfliteDb().updateData(
                        id: widget.contact.id,
                        name: ContactDetails.nameController.text,
                        number: ContactDetails.numberController.text,
                        url: ContactDetails.urlController.text,
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                            (route) => false,
                      );                    }
                  },
                  label: 'SAVE',
                ),
                CustomTextButton(
                  color: Colors.blue,
                  label: 'DELETE',
                  onPressed: () async{
                   await SqfliteDb().deleteData(id: widget.contact.id);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
