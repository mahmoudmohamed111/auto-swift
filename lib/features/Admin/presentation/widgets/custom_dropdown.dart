import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.valid,
    this.onChanged,
    this.value,
  });
  List<DropdownItem<String>> items;
  ValueListenable<String?>? value;
  String hint, valid;
  Function(dynamic data)? onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      buttonStyleData: const FormFieldButtonStyleData(
        height: 30,
        padding: EdgeInsets.only(right: 8),
      ),

      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),

      valueListenable: value,
      items: items,
      validator: (value) => value == null ? valid : null,
      isExpanded: true,
      onChanged: onChanged,
      hint: Text(hint),
    );
  }
}
