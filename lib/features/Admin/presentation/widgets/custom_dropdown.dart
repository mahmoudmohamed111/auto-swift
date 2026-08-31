import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    super.key,
    this.items,
    required this.hint,
    required this.valid,
    this.value,
  });
  List<DropdownItem<String>>? items;
  Function(String?)? onChanged;
  ValueListenable<String?>? value;
  String hint, valid;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      valueListenable: value,
      items: items,
      validator: (value) => value == null ? valid : null,
      isExpanded: true,
      onChanged: onChanged,
      hint: Text(hint),
    );
  }
}
