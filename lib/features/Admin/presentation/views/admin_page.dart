import 'dart:io';
import 'package:auto_swift/core/components/snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:auto_swift/core/components/custom_button.dart';
import 'package:auto_swift/core/components/custom_container.dart';
import 'package:auto_swift/core/components/custom_text_field.dart';
import 'package:auto_swift/features/Admin/presentation/widgets/custom_dropdown.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final speed = TextEditingController();
  final engine = TextEditingController();
  final seatNumber = TextEditingController();
  final model = TextEditingController();
  final price = TextEditingController();

  final List<String> carsBrand = ["Bmw", "Audi", "Porshe"];
  String? selectedBrand;
  File? imageFile;
  bool isLoading = false;

  final supabase = Supabase.instance.client;
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => imageFile = File(picked.path));
  }

  Future<void> addCar() async {
    if (imageFile == null || selectedBrand == null) return;

    setState(() => isLoading = true);
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      await supabase.storage.from('images').upload(fileName, imageFile!);
      final imageUrl = supabase.storage.from('images').getPublicUrl(fileName);

      await supabase.from('cars').insert({
        'engine': engine.text,
        'speed': speed.text,
        'seat_number': seatNumber.text,
        'model': model.text,
        'price': double.tryParse(price.text) ?? 0,
        'brand': selectedBrand,
        'image_url': imageUrl,
      });

      if (mounted) {
        Snack().success(context, "Car added successfully!");
      }
    } catch (e) {
      if (mounted) {
        Snack().error(context, "Error: $e");
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: const Text(
          "Admin Page",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  height: 50,
                  width: 50,
                  radius: 50,
                  color: Colors.red,
                ),
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: const Icon(CupertinoIcons.share_up),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: engine,
                    hint: "Car Engine",
                    type: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: speed,
                    hint: "Car Speed",
                    type: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: seatNumber,
                    hint: "Car Number",
                    type: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: model,
              hint: "Car Model",
              type: TextInputType.text,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: price,
              hint: "Car Price",
              type: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomDropdown(
              onChanged: (data) => setState(() => selectedBrand = data),
              value: ValueNotifier<String?>(selectedBrand),
              hint: "Car Brand",
              valid: "Please Select at least 1 item",
              items: carsBrand
                  .map(
                    (brand) => DropdownItem(value: brand, child: Text(brand)),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            CustomButton(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: Colors.black,
              radius: 20,
              onTap: isLoading ? null : addCar,
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
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
