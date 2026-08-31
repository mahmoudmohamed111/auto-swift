import 'package:auto_swift/core/components/custom_container.dart';
import 'package:auto_swift/core/components/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController speed = TextEditingController();
  TextEditingController Engine = TextEditingController();
  TextEditingController Seat_Number = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text("Admin Page"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  height: 40,
                  width: 40,
                  radius: 60,
                  color: Colors.red,
                ),
                Icon(CupertinoIcons.share_up),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: Engine,
                    hint: "Car Engine",
                    type: TextInputType.text,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: speed,
                    hint: "Car Speed",
                    type: TextInputType.text,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: Seat_Number,
                    hint: "Car Number",
                    type: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: Seat_Number,
              hint: "Car Number",
              type: TextInputType.number,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: Seat_Number,
              hint: "Car Number",
              type: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
