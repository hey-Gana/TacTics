import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/Data/notifiers.dart';

class Navbar extends StatelessWidget {
  Navbar({super.key});

  // int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_filled), label: "Home"),
            NavigationDestination(
              icon: Icon(Icons.model_training_rounded),
              label: "Rules",
            ),
            NavigationDestination(
              icon: Icon(Icons.play_circle_fill_rounded),
              label: "Play",
            ),
          ],
          onDestinationSelected: (value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}
