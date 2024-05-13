import 'package:contacts_flutter/core/routes/routes.dart';
import 'package:contacts_flutter/data/contact_controller.dart';
import 'package:contacts_flutter/presentation/widgets/item_contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListContact extends StatelessWidget {
  const ListContact({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ContactController>(ContactController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.newContact);
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: controller.contacts.length,
            itemBuilder: (context, index) {
              final contact = controller.contacts[index];
              return ItemContact(
                contact: contact,
                onEnter: () {
                  controller.setData(contact);
                  Get.toNamed(AppRoutes.editContact);
                },
                onDelete: controller.deleteContact,
              );
            },
          );
        }
      }),
    );
  }
}
