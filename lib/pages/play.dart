import 'package:flutter/material.dart';

class playPage extends StatelessWidget {
  const playPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  print("Classic");
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Classic Tic-Tac-Toe",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  print("Lock");
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Tic-Tac-Lock", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  print("GG");
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Gobblet Gobblers",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
