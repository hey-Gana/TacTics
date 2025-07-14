//This is the first page for the app - home page

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Make column only as big as needed
            children: [
              GridView.count(
                shrinkWrap: true, // important for using GridView inside Column
                padding: const EdgeInsets.all(20.0),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(9, (index) {
                  return FloatingActionButton(
                    onPressed: () {
                      //print(index);
                    },
                    splashColor: const Color.fromARGB(255, 109, 137, 187),

                    //child: Text('${index + 1}'),
                  );
                }),
              ),
              const SizedBox(height: 20),
              const Text(
                "TacTics",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Competitive twists on classic Tic-Tac-Toe!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
