import 'package:flutter/material.dart';
import 'package:ieee_week15_task2/components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../db/sqflite_db.dart';
import '../screens/home_screen.dart';

class CustomBottomSheet extends StatelessWidget {
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController urlController = TextEditingController();


    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * .45,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'Contact Name',
                      controller: nameController,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Title can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      label: 'Contact Number',
                      controller: numberController,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Author can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      label: 'Contact Image Url',
                      controller: urlController,
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
                      urlController: urlController,
                      numberController: numberController,
                      nameController: nameController,
                      onPressed: ()async{
                        if (formKey.currentState!.validate()) {
                          await SqfliteDb().insertData(
                            name: nameController.text,
                            number: numberController.text,
                            url: urlController.text,
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                            (route) => false,
                          );
                        }
                      },
                      label: 'ADD',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
