// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sstsf/src/pages/asesores_list.dart';
import 'package:sstsf/src/pages/clientes_list.dart';
import 'package:sstsf/src/pages/proyectos_list.dart';
import 'package:sstsf/src/pages/inicio_page.dart';
import 'package:sstsf/src/pages/sing_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'Ingresar',
      routes: <String, WidgetBuilder>{
        'Ingresar': (BuildContext context) => SingIn(),
        'Inicio': (BuildContext context) => PrincipalApp(),
        'Clientes': (BuildContext context) => ClientesList(),
        'Asesores': (BuildContext context) => AsesoresList(),
        'Proyectos': (BuildContext context) => ProyectosList(),
      },
    );
  }
}
