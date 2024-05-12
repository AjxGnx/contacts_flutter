import 'package:contacts_flutter/presentation/widgets/item_contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../domain/entities/contact.dart';

class ListContact extends StatelessWidget {
  const ListContact({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Contact> contacts = snapshot.data ?? [];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Contacts'),
            ),
            body: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ItemContact(
                  contact: contact,
                  onEnter: () {
                  },
                  onDelete: () {
                  },
                );
              },
            ),
          );
        }
      },
    );
  }

  Future<List<Contact>> fetchContacts() async {
    final response = await http.get(Uri.parse('https://71bf-186-155-16-253.ngrok-free.app/api/contacts/'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> contactData = jsonData['data']['records'];

      List<Contact> contacts = contactData.map((data) => Contact.fromJson(data)).toList();
      return contacts;
    } else {
      throw Exception('Failed to load contacts');
    }
  }
}
