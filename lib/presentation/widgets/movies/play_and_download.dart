import 'package:flutter/material.dart';

class PlayAndDownload extends StatelessWidget {
  const PlayAndDownload({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: () {},
          child: Row(
            children: const [
              Icon(Icons.play_arrow),
              Text("Play first episode",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ))
            ],
          ),
        ),
        const SizedBox(height: 10),
        FilledButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(250, 255, 255, 255))),
            onPressed: () {},
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.download),
                  Text("Download",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
            )),
      ],
    );
  }
}
