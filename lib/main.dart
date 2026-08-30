import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Auto_swift_app());
}

class Auto_swift_app extends StatelessWidget {
  const Auto_swift_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold());
  }
}
