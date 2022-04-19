import 'package:flutter/material.dart';
import 'package:secure_app/services/validation.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required TextEditingController emailController,
    required FocusNode emailFocusNode,
  })  : _emailController = emailController,
        _emailFocusNode = emailFocusNode,
        super(key: key);

  final TextEditingController _emailController;
  final FocusNode _emailFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      validator: Validation.email,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your email',
        label: Text('Email'),
      ),
    );
  }
}
