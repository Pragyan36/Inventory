import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventorymanagement/common/constant/Textstyle.dart';

Widget buildLabeledField({
  required String label,
  required TextEditingController controller,
  required String? Function(String?) validator,
  IconData? icon,
  String? imagePath,
  VoidCallback? onSuffixTap,
  bool obscureText = false,
  bool isNumber = false,
  void Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: authTitleStyle),
      TextFormField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters:
            isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
        controller: controller,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        obscureText: obscureText,
        readOnly: false,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white30),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: imagePath != null
              ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      imagePath!,
                      color: Colors.white70,
                      height: 20,
                      width: 20,
                    ),
                  ),
                )
              : icon != null
                  ? Icon(icon, color: Colors.white70)
                  : null,
          errorStyle: const TextStyle(color: Colors.redAccent),
          hintStyle: const TextStyle(color: Colors.white54),
        ),
      ),
    ],
  );
}
