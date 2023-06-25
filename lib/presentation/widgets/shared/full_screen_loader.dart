import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  final List<String> messages = [
    'cargando',
    'No te me apures',
    "Un gran poder con lleva una gran responsabilidad"
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          StreamBuilder(
              stream: getLoadingMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Cargando...');

                return Text(snapshot.data!);
              }),
        ],
      ),
    );
  }
}
