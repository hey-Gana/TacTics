import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/pages/rules.dart';

class Xolock extends StatelessWidget {
  const Xolock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Tic-Tac-Lock")),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 60,
                        ), // distance from top
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 400,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: RulesPage(),
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            },
            icon: Icon(Icons.model_training_rounded),
          ),
        ],
      ),
      body: const Center(
        child: Text("XO Lock Game Page", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
