import 'package:flutter/material.dart';

import '../../domain/entities/contact.dart';

class ItemContact extends StatelessWidget {
  final VoidCallback onEnter;
  final VoidCallback onDelete;
  final Contact contact;


  const ItemContact({
    super.key,
    required this.onEnter,
    required this.onDelete,
    required this.contact
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.grey[200],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          onTap: onEnter,
          tileColor: Colors.white,
          title: Text(
            contact.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            contact.phoneNumber,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
