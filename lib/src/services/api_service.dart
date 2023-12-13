// Importa Dio
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<bool> signIn(String email, String password) async {
    final apiUrl = 'https://sstsf.net/api/v1/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error durante la solicitud HTTP: $e');
      throw Exception('Las credenciales son incorrectas');
    }
  }

  static Future<List<Map<String, dynamic>>> getClientes() async {
    try {
      final response =
          await http.get(Uri.parse('https://sstsf.net/api/v1/clientes'));

      if (response.statusCode == 200) {
        String jsonsDataString = response.body.toString();
        final _data = jsonDecode(jsonsDataString);
        print(_data.toString());
        List<Map<String, dynamic>> clientes = [];

        for (var clienteData in _data) {
          // Asegúrate de ajustar estas claves según la estructura de tu API
          Map<String, dynamic> cliente = {
            'id_cliente': clienteData['id_cliente'],
            'nombre_cliente': clienteData['nombre_cliente'],
            'nit': clienteData['nit'],
            'direccion': clienteData['direccion'],
            'telefono': clienteData['telefono'],
            'actividad_comercial': clienteData['actividad_comercial'],
            'Codigo_CIUU': clienteData['Codigo_CIUU'],
            // Agregar más campos según sea necesario
          };

          clientes.add(cliente);
        }

        return clientes;
      } else {
        throw Exception(
            'Error al cargar los clientes. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al cargar los clientes: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getAsesores() async {
    try {
      final response =
          await http.get(Uri.parse('https://sstsf.net/api/v1/asesores'));

      if (response.statusCode == 200) {
        String jsonsDataString = response.body.toString();
        final _data = jsonDecode(jsonsDataString);
        print(_data.toString());
        List<Map<String, dynamic>> asesores = [];

        for (var asesorData in _data) {
          // Asegúrate de ajustar estas claves según la estructura de tu API
          Map<String, dynamic> asesor = {
            'id_asesor': asesorData['id_asesor'],
            'nombre_asesor': asesorData['nombre_asesor'],
            'profesion_asesor': asesorData['profesion_asesor'],
            'licenciaAsesor': asesorData['licenciaAsesor'],
          };

          asesores.add(asesor);
        }

        return asesores;
      } else {
        throw Exception(
            'Error al cargar los asesores. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al cargar los asesores: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getProyectos() async {
    try {
      final response =
          await http.get(Uri.parse('https://sstsf.net/api/v1/proyectos'));

      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        final data = jsonDecode(jsonDataString);
        print(data.toString());

        List<Map<String, dynamic>> proyectos = [];

        for (var proyectoData in data) {
          // Assuming the API returns project data with information from clientes and asesores
          Map<String, dynamic> proyecto = {
            'idProyecto': proyectoData['idProyecto'],
            'Nombre': proyectoData[
                'Nombre'], // Assuming the project name is under the 'nombre' key
            'Riesgos': proyectoData['Riesgos'],
            'Progreso': proyectoData['Progreso'],
            // Add more fields according to your project structure
          };

          proyectos.add(proyecto);
        }

        return proyectos;
      } else {
        throw Exception(
            'Error al cargar los proyectos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al cargar los proyectos: $e');
    }
  }
}
