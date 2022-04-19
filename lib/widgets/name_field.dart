import 'package:flutter/material.dart';
import 'package:secure_app/services/validation.dart';

class NameField extends StatelessWidget {
  const NameField({
    Key? key,
    required TextEditingController nameController,
    required FocusNode nameFocusNode,
  })  : _nameController = nameController,
        _nameFocusNode = nameFocusNode,
        super(key: key);

  final TextEditingController _nameController;
  final FocusNode _nameFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      focusNode: _nameFocusNode,
      validator: Validation.name,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your name here',
        label: Text('name'),
      ),
    );
  }
}
