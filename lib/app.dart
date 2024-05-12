import 'package:contacts_flutter/presentation/screens/list_contact.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListContact(),
    );
  }
}
