import 'package:flutter/material.dart';
import 'package:sstsf/src/pages/asesores_list.dart';
import 'package:sstsf/src/pages/inicio_page.dart';
import 'package:sstsf/src/pages/proyectos_list.dart';
import 'package:sstsf/src/services/api_service.dart';

class ClientesList extends StatefulWidget {
  const ClientesList({Key? key}) : super(key: key);

  @override
  State<ClientesList> createState() => _ClientesListState();
}

class _ClientesListState extends State<ClientesList> {
  late Future<List<Map<String, dynamic>>> _clientes;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _refreshClientes();
  }

  Future<void> _refreshClientes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _clientes = ApiService.getClientes();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
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
        future: _clientes,
        builder: (context, snapshot) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final clientes = snapshot.data;
            if (clientes == null) {
              return Center(child: Text('No hay datos'));
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  await _refreshClientes();
                },
                child: ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (context, index) {
                    final cliente = clientes[index];
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ListTile(
                        title: Container(
                          color: Colors.blue, // Color de fondo azul
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ID Cliente: ${cliente['id_cliente']}',
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
                            Text('Razón Social: ${cliente['nombre_cliente']}'),
                            Text('NIT: ${cliente['nit']}'),
                            Text('Dirección: ${cliente['direccion']}'),
                            Text('Teléfono: ${cliente['telefono']}'),
                            Text(
                                'Actividad Comercial: ${cliente['actividad_comercial']}'),
                            Text('Código CIUU: ${cliente['Codigo_CIUU']}'),
                            // Agregar más campos según sea necesario
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
