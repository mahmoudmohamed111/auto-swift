import 'package:auto_swift/core/components/custom_button.dart';
import 'package:auto_swift/core/components/custom_container.dart';
import 'package:auto_swift/core/components/custom_text_field.dart';
import 'package:auto_swift/features/Admin/presentation/widgets/custom_dropdown.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  List<String> Cars_Brand = ["Bmw", "Audi", "Porshe"];
  String? selected_brand;
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
              controller: model,
              hint: "Car Model",
              type: TextInputType.text,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: price,
              hint: "Car Price",
              type: TextInputType.number,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CustomDropdown(
                onChanged: (data) {
                  setState(() {
                    selected_brand = data;
                  });
                },
                value: ValueNotifier<String?>(selected_brand),
                hint: "Car Brand",
                valid: "Please Select at least 1 item",
                items: Cars_Brand.map(
                  (brand) => DropdownItem(value: brand, child: Text(brand)),
                ).toList(),
              ),
            ),
            SizedBox(height: 16),
            CustomButton(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: Colors.black,
              radius: 20,
              onTap: () {},
              child: Center(
                child: Text(
                  "Add Car",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
