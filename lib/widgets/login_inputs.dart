import 'package:flutter/material.dart';

class LoginInputs extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? type;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool obscureText;

  const LoginInputs({
    super.key,
    required this.controller,
    required this.label,
    this.type,
    required this.hint,
    this.validator,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  _LoginInputsState createState() => _LoginInputsState();
}

class _LoginInputsState extends State<LoginInputs> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(color: Colors.white),
          ),
          TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            style: const TextStyle(color: Colors.white),
            keyboardType: widget.type,
            obscureText: widget.obscureText,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[850],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            validator: widget.validator,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
              
              if (_focusNode.hasFocus && widget.validator != null) {
                Form.of(context).validate();
              }
            },
          ),
        ],
      ),
    );
  }
}
