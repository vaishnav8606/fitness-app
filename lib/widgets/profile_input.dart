import 'package:flutter/material.dart';


class ProfileInputs extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? type;
  const ProfileInputs(
      {super.key,
      required this.label,
      required this.controller,
      this.type, required TextInputType inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              keyboardType: type,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 26, 198, 195)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter $label';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
