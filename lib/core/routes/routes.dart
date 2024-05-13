import 'package:contacts_flutter/presentation/screens/edit_contact.dart';
import 'package:contacts_flutter/presentation/screens/list_contact.dart';
import 'package:contacts_flutter/presentation/screens/new_contact.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const listContact = '/';
  static const newContact = '/new-contact';
  static const editContact = '/edit-contact';

  static final routes = <GetPage>[
    GetPage(name: listContact, page: () => const ListContact()),
    GetPage(name: newContact, page: () => const NewContact()),
    GetPage(name: editContact, page: () => const EditContact())
  ];
}
