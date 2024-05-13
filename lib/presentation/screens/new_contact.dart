import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/contact_controller.dart';

class NewContact extends StatelessWidget {
  const NewContact({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                    errorText: controller.errorMessageName.value == ''
                        ? null
                        : controller.errorMessageName.value,
                  ),
                  controller: controller.nameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    errorText: controller.errorMessagePhoneNumber.value == ''
                        ? null
                        : controller.errorMessagePhoneNumber.value,
                  ),
                  controller: controller.phoneNumberController,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.newContact();
                  },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Save'),
                )
              ],
            ),
          )),
    );
  }
}
