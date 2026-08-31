import 'package:auto_swift/features/Admin/presentation/views/admin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const Auto_swift_app());
}

class Auto_swift_app extends StatelessWidget {
  const Auto_swift_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: AdminPage(),
    );
  }
}
