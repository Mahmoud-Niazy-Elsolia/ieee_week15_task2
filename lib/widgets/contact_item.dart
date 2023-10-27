import 'package:flutter/material.dart';
import 'package:ieee_week15_task2/models/contact_model.dart';
import 'package:ieee_week15_task2/screens/contact_details.dart';

class ContactItem extends StatelessWidget {
  final ContactModel contact;

  const ContactItem({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContactDetails(contact: contact,),
          ),
        );
      },
      child: Column(
        children: [
          Image.network(
            contact.imageUrl,
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            contact.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          Text(
            contact.number,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
