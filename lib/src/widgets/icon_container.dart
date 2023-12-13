import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final String url;
  const IconContainer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: Image.asset(
        this.url, // Reemplaza 'tu_imagen.jpg' con la ruta correcta de tu imagen
        width: 500.0, // ajusta el ancho según tus necesidades
        height: 200.0, // ajusta la altura según tus necesidades
        fit: BoxFit.cover, // ajusta el modo de ajuste según tus necesidades
      ),
    );
  }
}
