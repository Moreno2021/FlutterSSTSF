import 'package:flutter/material.dart';
import 'package:sstsf/src/pages/asesores_list.dart';
import 'package:sstsf/src/pages/clientes_list.dart';
import 'package:sstsf/src/pages/inicio_page.dart';
import 'package:sstsf/src/services/api_service.dart';

class ProyectosList extends StatefulWidget {
  const ProyectosList({Key? key}) : super(key: key);

  @override
  State<ProyectosList> createState() => _ProyectosListState();
}

class _ProyectosListState extends State<ProyectosList> {
  late Future<List<Map<String, dynamic>>> _proyectos;

  @override
  void initState() {
    super.initState();
    _proyectos = ApiService.getProyectos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Proyectos'),
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
                    size: 60,
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
        future: _proyectos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final proyectos = snapshot.data;
            if (proyectos == null) {
              return Center(child: Text('No hay datos'));
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _proyectos = ApiService.getProyectos();
                  });
                },
                child: ListView.builder(
                  itemCount: proyectos.length,
                  itemBuilder: (context, index) {
                    final proyecto = proyectos[index];
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ListTile(
                        title: Container(
                          color: Colors.blue, // Color de fondo azul
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ID Proyecto: ${proyecto['idProyecto']}',
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
                            Text('Nombre: ${proyecto['Nombre']}'),
                            Text('Riesgo: ${proyecto['Riesgos']}'),
                            Text('Progreso: ${proyecto['Progreso']}'),
     
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
