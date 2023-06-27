import 'package:flutter/material.dart';

class LoadingMessageWidget extends StatelessWidget {
  const LoadingMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(), // Indicador de carga circular
          SizedBox(height: 15), // Espacio entre el indicador y el texto
          Text(
            'Cargando...', // Texto de "Cargando..."
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
