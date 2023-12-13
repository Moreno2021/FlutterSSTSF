import 'package:flutter/material.dart';
import 'package:sstsf/src/pages/clientes_list.dart';
import 'package:sstsf/src/pages/inicio_page.dart';
import 'package:sstsf/src/pages/proyectos_list.dart';
import 'package:sstsf/src/services/api_service.dart';

class AsesoresList extends StatefulWidget {
  const AsesoresList({Key? key}) : super(key: key);

  @override
  State<AsesoresList> createState() => _AsesoresListState();
}

class _AsesoresListState extends State<AsesoresList> {
  late Future<List<Map<String, dynamic>>> _asesores;

  @override
  void initState() {
    super.initState();
    _asesores = ApiService.getAsesores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Asesores'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size:
                        60, // Ajusta el tamaño del icono según tus preferencias
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menú',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 10),
                  Text('Inicio'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrincipalApp()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Text('Clientes'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientesList()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.person_outline),
                  SizedBox(width: 10),
                  Text('Asesores'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AsesoresList()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.folder),
                  SizedBox(width: 10),
                  Text('Proyectos'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProyectosList()),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _asesores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final Asesores = snapshot.data;
            if (Asesores == null) {
              return Center(child: Text('No hay datos'));
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _asesores = ApiService.getAsesores();
                  });
                },
                child: ListView.builder(
                  itemCount: Asesores.length,
                  itemBuilder: (context, index) {
                    final asesor = Asesores[index];
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ListTile(
                        title: Container(
                          color: Colors.blue, // Color de fondo azul
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ID Asesor: ${asesor['id_asesor']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // Negrita
                                color: Colors
                                    .white, // Color del texto blanco para contrastar
                              ),
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nombre: ${asesor['nombre_asesor']}'),
                            Text('Profesión: ${asesor['profesion_asesor']}'),
                            Text('Licencia: ${asesor['licenciaAsesor']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
