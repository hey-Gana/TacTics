import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/pages/gg_page.dart';

void main() {
  runApp(const gggame());
}

class gggame extends StatefulWidget {
  const gggame({super.key});

  @override
  State<gggame> createState() => _gggameState();
}

class _gggameState extends State<gggame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: GgPage());
  }
}
