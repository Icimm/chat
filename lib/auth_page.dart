import 'dart:html';

import 'package:chat/components/auth_form.dart';
import 'package:chat/components/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool __isLoading = false;

  void _handleSubmit(AuthFormData formData) {
    setState(() => __isLoading = true);
    print('AuthPage...');
    print(formData.email);
    setState(() => __isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
              child: SingleChildScrollView(
            child: AuthForm(onSubmit: _handleSubmit),
           )
          ),
          if(__isLoading) Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
