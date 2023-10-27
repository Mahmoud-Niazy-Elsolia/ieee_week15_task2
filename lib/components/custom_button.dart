import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  final String label ;
  void Function()? onPressed;


  CustomButton({
    super.key,
    required this.urlController,
    required this.numberController,
    required this.nameController,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,


      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
