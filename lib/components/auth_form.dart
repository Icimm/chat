import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _FormKey = GlobalKey<FormState>();
  final _FormData = AuthFormData();

  void _handleImagePick(File image) {
    _FormData.Image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    final isValid = _FormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_FormData.Image == null && _FormData.isSignup) {
      return _showError('Imagem não selecionada!');
    }

    widget.onSubmit(_FormData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _FormKey,
          child: Column(
            children: [
              if (_FormData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_FormData.isSignup)
                TextFormField(
                  key: ValueKey('name'),
                  onChanged: (name) => _FormData.name = name,
                  initialValue: _FormData.name,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter no minimo 5 caracteres.';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: ValueKey('email'),
                onChanged: (email) => _FormData.name = email,
                initialValue: _FormData.email,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (_email) {
                  final email = _email ?? '';
                  if (!email.contains('@')) {
                    return 'E_mail informado não é válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: ValueKey('passsword'),
                onChanged: (password) => _FormData.name = password,
                initialValue: _FormData.password,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.length < 6) {
                    return 'Senha deve ter no minimo 6 caracteres.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _FormData.isLogin ? 'Entrar' : 'Cadastrar',
                ),
              ),
              TextButton(
                child: Text(
                  _FormData.isLogin
                      ? 'Criar uma nova conta ?'
                      : 'Já possui Conta ?',
                ),
                onPressed: () {
                  setState(() {
                    _FormData.toggleAuthMode();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
