import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.model_training_rounded),
          label: "Rules",
        ),
        NavigationDestination(
          icon: Icon(Icons.play_circle_fill_rounded),
          label: "Play",
        ),
      ],
    );
  }
}
