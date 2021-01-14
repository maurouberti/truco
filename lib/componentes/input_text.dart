import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeHolder;
  final IconData icon;
  final bool readOnly;
  final bool isRequired;
  final Function onChanged;
  final Function onSaved;
  final String initialValue;

  const InputText({
    Key key,
    this.controller,
    @required this.label,
    this.placeHolder,
    this.icon,
    this.readOnly = false,
    this.isRequired = false,
    this.onChanged,
    this.onSaved,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          icon: icon == null ? null : Icon(icon),
          labelText: label,
          hintText: placeHolder,
        ),
        onChanged: onChanged,
        onSaved: onSaved,
        validator: (value) {
          if (value.isEmpty && isRequired) {
            return 'O campo é obrigatório';
          }
          return null;
        },
        initialValue: initialValue,
      ),
    );
  }
}
