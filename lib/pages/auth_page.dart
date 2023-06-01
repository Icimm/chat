import 'package:chat/components/auth_form.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool __isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() => __isLoading = true);

      if (formData.isLogin) {
        //Login
        await AuthMockService().signup(
          formData.name, 
          formData.email,
          formData.password,
          formData.Image,       
        );
      } else {
        //Signup
        await AuthMockService().login(
          formData.email,
          formData.password,
        );
      }
    } catch (error) {
      //Tratar Erro!
    } finally {
      setState(() => __isLoading = false);
    }
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
          )),
          if (__isLoading)
            Container(
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