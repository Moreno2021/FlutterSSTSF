import 'package:flutter/material.dart';
import 'package:sstsf/src/pages/sing_in.dart';
import 'package:sstsf/src/widgets/icon_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(37, 93, 214, 1),
                Color.fromARGB(0, 218, 215, 255)
              ],
              begin: Alignment.topCenter
            )
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 200
              ),
              children: <Widget> [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  IconContainer(
                    url: 'images/SST-SF.png',
                  ),
                  Text(
                    'Bienvenido!!',
                    style: TextStyle(
                      fontFamily: 'FredokaOne',
                      fontSize: 18.0
                    ),
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80.0,
                    child: FloatingActionButton(
                      hoverColor: Colors.blue,
                      onPressed: (){
                        final route = MaterialPageRoute(
                          builder: (context) => SingIn());
                          Navigator.push(context, route);
                      },
                      child: Text('Ingresar',
                        style: TextStyle(
                          fontFamily: 'FredokaOne',
                          fontSize: 30.0
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  ],
                )
              ],
          )
        ),
      ),
    );
  }
}