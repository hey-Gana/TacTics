//This routes across different pages

import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/Data/notifiers.dart';
import 'package:gobblets_gobblers_game/pages/gameselection.dart';
import 'package:gobblets_gobblers_game/pages/home.dart';
import 'package:gobblets_gobblers_game/pages/play.dart';
import 'package:gobblets_gobblers_game/pages/rules.dart';
import 'package:gobblets_gobblers_game/widgets/navbar.dart';

//List of pages in the app
// final List<Widget> pages = [HomePage(), RulesPage(), PlayPage()];

class RoutingPage extends StatefulWidget {
  const RoutingPage({super.key});

  @override
  State<RoutingPage> createState() => _RoutingPageState();
}

// class _RoutingPageState extends State<RoutingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Center(child: Text("Let's Play!"))),
//       body: ValueListenableBuilder(
//         //The ValueListenableBuilder will build the pages as per the user's selection using the selectedPageNotifier
//         valueListenable: selectedPageNotifier,
//         builder: (context, selectedPage, child) {
//           return pages.elementAt(selectedPage);
//         },
//       ),
//       bottomNavigationBar: Navbar(),
//     );
//   }
// }

class _RoutingPageState extends State<RoutingPage> {
  //List of pages in the app
  final List<Widget> pages = const [
    HomePage(),
    RulesPage(),
    GameSelectionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedIndex, _) {
        return Scaffold(
          appBar: AppBar(title: const Center(child: Text("Let's Play!"))),
          body: pages[selectedIndex],
          bottomNavigationBar: const Navbar(),
        );
      },
    );
  }
}

// class _RoutingPageState extends State<RoutingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Center(child: Text("Let's Play!"))),
//       body: //Ensures that when the game pages are clicked, it loads on top smoothly ;
//           Navigator(
//         onGenerateRoute: (settings) {
//           return MaterialPageRoute(
//             builder: (context) {
//               //The ValueListenableBuilder will build the pages as per the user's selection using the selectedPageNotifier
//               return ValueListenableBuilder(
//                 valueListenable: selectedPageNotifier,
//                 builder: (context, selectedPage, child) {
//                   return pages[selectedPage];
//                 },
//               );
//             },
//           );
//         },
//       ),
//       bottomNavigationBar: Navbar(),
//     );
//   }
// }
