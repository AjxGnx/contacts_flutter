import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../domain/entities/contact.dart';
import 'package:http/http.dart' as http;

class ContactController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  var isLoading = true.obs;
  RxList<Contact> contacts = <Contact>[].obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final Rx<Contact> currentContact = Contact.empty().obs;
  Rx<String> errorMessageName = ''.obs;
  Rx<String> errorMessagePhoneNumber = ''.obs;

  void clearForm() {
    nameController.text = '';
    phoneNumberController.text = '';
  }

  void setData(Contact contact) {
    currentContact.value = contact;
    nameController.text = contact.name;
    phoneNumberController.text = contact.phoneNumber;
  }

  bool validateForm() {
    if (nameController.text.isEmpty) {
      errorMessageName.value = 'Name is required';
      return false;
    }
    errorMessageName.value = '';

    if (phoneNumberController.text.isEmpty) {
      errorMessagePhoneNumber.value = 'Phone Number is required';
      return false;
    }
    errorMessagePhoneNumber.value = '';

    return true;
  }

  Future<void> fetchContacts() async {
    final response = await http.get(Uri.parse(
        'https://71bf-186-155-16-253.ngrok-free.app/api/contacts/?page=1&limit=500'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> contactData = jsonData['data']['records'];

      contacts.value =
          contactData.map((data) => Contact.fromJson(data)).toList();
      isLoading.value = false;
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  Future<void> newContact() async {
    if (validateForm()) {
      var body = jsonEncode(<String, String>{
        'name': nameController.text,
        'phone_number': phoneNumberController.text
      });

      isLoading.value = true;
      final response = await http.post(
        Uri.parse('https://71bf-186-155-16-253.ngrok-free.app/api/contacts/'),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        contacts.add(Contact.fromJson(jsonData['data']));
        isLoading.value = false;
        clearForm();
        Get.back();
      } else {
        isLoading.value = false;
        throw Exception('Failed to create contact');
      }
    }
  }

  Future<bool> deleteContact(int id) async {
    final response = await http.delete(Uri.parse(
        'https://71bf-186-155-16-253.ngrok-free.app/api/contacts/$id'));

    if (response.statusCode == 200) {
      contacts.value = contacts.where((element) => element.id != id).toList();
      return true;
    }
    return false;
  }

  Future<void> editContact() async {
    if (validateForm()) {
      var body = jsonEncode(<String, String>{
        'name': nameController.text,
        'phone_number': phoneNumberController.text
      });

      isLoading.value = true;
      final response = await http.put(
        Uri.parse(
            'https://71bf-186-155-16-253.ngrok-free.app/api/contacts/${currentContact.value.id}'),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final int indexContact = contacts.indexOf(contacts
            .firstWhere((element) => element.id == currentContact.value.id));
        contacts[indexContact] = Contact.fromJson(jsonData['data']);
        isLoading.value = false;
        clearForm();
        Get.back();
      } else {
        isLoading.value = false;
        throw Exception('Failed to create contact');
      }
    }
  }
}
