import 'package:auto_swift/features/Admin/presentation/views/admin_page.dart';
import 'package:auto_swift/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://marpbzqwxtgslasycdvb.supabase.co',
    publishableKey: "sb_publishable_mndCc5XwPD5Q9j5WJoWBZQ_spwupQHi",
  );
  runApp(const Auto_swift_app());
}

class Auto_swift_app extends StatelessWidget {
  const Auto_swift_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
