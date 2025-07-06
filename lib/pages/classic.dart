// import 'package:flutter/material.dart';

// class ClassicPage extends StatefulWidget {
//   const ClassicPage({super.key});

//   @override
//   State<ClassicPage> createState() => _ClassicPageState();
// }

// class _ClassicPageState extends State<ClassicPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Classic Tic-Tac-Toe')),
//       body: const Center(
//         child: Text(
//           'Classic Tic-Tac-Toe Game Screen',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

// class ClassicPage extends StatelessWidget {
//   const ClassicPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Classic")),
//       body: const Center(
//         child: Text("Classic Game Page", style: TextStyle(fontSize: 24)),
//       ),
//     );
//   }
// }

class ClassicPage extends StatelessWidget {
  const ClassicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Classic Tic-Tac-Toe")),
      body: const Center(
        child: Text("This is the game screen", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
