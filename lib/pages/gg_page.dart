//This is the first page for the app - home page

import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/widgets/Navbar.dart';

class GgPage extends StatelessWidget {
  const GgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Let's Play!"))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Make column only as big as needed
              children: [
                GridView.count(
                  shrinkWrap:
                      true, // important for using GridView inside Column
                  padding: const EdgeInsets.all(20.0),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(9, (index) {
                    return FloatingActionButton(
                      onPressed: () {
                        print("Click on Play!");
                      },
                      //child: Text('${index + 1}'),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                const Text(
                  "TacTics",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Competitive twists on classic Tic Tac Toe",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
