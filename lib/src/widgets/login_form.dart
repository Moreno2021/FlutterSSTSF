// login_form.dart
import 'package:flutter/material.dart';
import 'package:sstsf/src/services/api_service.dart';
import 'package:sstsf/src/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, required this.onSignIn}) : super(key: key);

  final Future<void> Function(String, String) onSignIn;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '';
  String _password = '';

  _submit() async {
    if (_formKey.currentState?.validate() == true) {
      bool loginSuccess = await ApiService.signIn(_email, _password);

      if (loginSuccess) {
        await widget.onSignIn(_email, _password);
      } else {
        // Muestra una alerta si el inicio de sesión no tiene éxito
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content:
                  Text('Las credenciales son incorrectas. Inténtalo de nuevo.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          InputText(
            label: 'Correo',
            hint: 'Correo',
            keyboard: TextInputType.emailAddress,
            icono: Icon(Icons.verified_user),
            onChanged: (data) {
              _email = data;
            },
            validator: (data) {
              if (data?.contains('@') == false) {
                return 'Correo Inválido';
              }
              return null;
            },
          ),
          Divider(
            height: 15.0,
          ),
          InputText(
            hint: 'Contraseña',
            label: 'Contraseña',
            obsecure: true,
            icono: Icon(Icons.lock_outline),
            onChanged: (data) {
              _password = data;
            },
            validator: (data) {
              if (data?.trim().length == 0) {
                return 'Contraseña Inválida';
              }
              return null;
            },
          ),
          Divider(
            height: 15.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              child: Text(
                'Ingresar',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
