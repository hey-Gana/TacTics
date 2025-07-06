import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/routingpage.dart';

void main() {
  runApp(const GGgame());
}

class GGgame extends StatefulWidget {
  const GGgame({super.key});

  @override
  State<GGgame> createState() => _GGgameState();
}

class _GGgameState extends State<GGgame> {
  @override
  Widget build(BuildContext context) {
    //Builds the RoutingPage which can re-route to different pages
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoutingPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
