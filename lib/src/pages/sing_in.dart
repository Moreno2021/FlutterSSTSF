import 'package:flutter/material.dart';
import 'package:sstsf/src/services/api_service.dart';
import 'package:sstsf/src/widgets/login_form.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  Future<void> _handleSignIn(String email, String password) async {
    try {
      final success = await ApiService.signIn(email, password);
      if (success) {
        print('Inicio de sesión exitoso'); // Agrega esta línea de depuración
        // Navegar a la pantalla principal si el inicio de sesión es exitoso
        Navigator.pushReplacementNamed(context, 'Inicio');
      } else {
        // Muestra una alerta si las credenciales son incorrectas
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
    } catch (e) {
      print('Error durante el inicio de sesión: $e');
      // Manejar otros errores si es necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromRGBO(0, 60, 255, 1),
              Color.fromRGBO(75, 117, 255, 1),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.topCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 200,
          ),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 120,
                    ),
                    SizedBox(height: 10),
                  ],
                ),

                Text(
                  'Inicio de Sesión',
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                ),
                Divider(
                  height: 10.0,
                ),
                // Formulario
                LoginForm(onSignIn: _handleSignIn),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
