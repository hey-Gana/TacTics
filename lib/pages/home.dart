import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/Data/notifiers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // List of widgets displayed in the grid cells
  final List<Widget> displayXO = const [
    Text('X', style: TextStyle(fontSize: 48, color: Colors.white)),
    Text('O', style: TextStyle(fontSize: 48, color: Colors.white)),
    Text('O', style: TextStyle(fontSize: 48, color: Colors.white)),
    Text('O', style: TextStyle(fontSize: 48, color: Colors.white)),
    Icon(
      Icons.play_circle_fill_sharp,
      size: 48,
      color: Colors.white,
    ), // middle box with bounce
    Text('X', style: TextStyle(fontSize: 48, color: Colors.white)),
    Text('O', style: TextStyle(fontSize: 48, color: Colors.white)),
    Text('X', style: TextStyle(fontSize: 48, color: Colors.white)),
    Text('X', style: TextStyle(fontSize: 48, color: Colors.white)),
  ];

  @override
  void initState() {
    super.initState();

    // Animation controller for bouncing effect
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    // Tween going from 0 to 10 pixels for bounce height
    _animation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text(
                "TacTics",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold, // Title remains bold
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 400, // fixed height to contain grid
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    // Wrap the middle item with a bouncing animation
                    Widget content = displayXO[index];
                    if (index == 4) {
                      content = AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              -_animation.value,
                            ), // up and down bounce
                            child: child,
                          );
                        },
                        child: displayXO[index],
                      );
                    }

                    return Material(
                      color: const Color.fromARGB(255, 37, 60, 99),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          if (index == 4) {
                            // Update the notifier to switch to play page
                            selectedPageNotifier.value = 2;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 19, 26, 34),
                            ),
                          ),
                          child: Center(child: content),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Competitive variations of Tic-Tac-Toe!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal, // subtitle normal weight
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
