import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/routingpage.dart';

void main() {
  runApp(const GGgame());
}

class GGgame extends StatelessWidget {
  const GGgame({super.key});

  @override
  Widget build(BuildContext context) {
    //Builds the RoutingPage which can re-route to different pages
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RootNavigatorWrapper(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}

class RootNavigatorWrapper extends StatelessWidget {
  const RootNavigatorWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute:
          (_) => MaterialPageRoute(builder: (_) => const RoutingPage()),
    );
  }
}
