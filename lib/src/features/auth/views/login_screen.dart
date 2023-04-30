import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (input) {
                if (input == null) {
                  return 'Por favor introduzca el usuario';
                }
                return null;
              },
              onSaved: (input) => email = input!,
              decoration: const InputDecoration(
                labelText: 'Usuario',
              ),
            ),
            TextFormField(
              obscureText: true,
              validator: (input) {
                if (input == null) {
                  return 'Por favor introduzca la contraseña';
                }
                return null;
              },
              onSaved: (input) => password = input!,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Perform login action with email and password
                }
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
