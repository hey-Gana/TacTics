//This routes across different pages

import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/Data/notifiers.dart';
import 'package:gobblets_gobblers_game/pages/home.dart';
import 'package:gobblets_gobblers_game/pages/play.dart';
import 'package:gobblets_gobblers_game/pages/rules.dart';
import 'package:gobblets_gobblers_game/widgets/navbar.dart';

//List of pages in the app
List<Widget> pages = [HomePage(), RulesPage(), playPage()];

class RoutingPage extends StatefulWidget {
  const RoutingPage({super.key});

  @override
  State<RoutingPage> createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Let's Play!"))),
      body: ValueListenableBuilder(
        //The ValueListenableBuilder will build the pages as per the user's selection using the selectedPageNotifier
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
