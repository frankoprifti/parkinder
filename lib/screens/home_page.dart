import 'package:flutter/material.dart';
import 'package:parkinder/screens/summary_view.dart';
import 'package:parkinder/widgets/tinder_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _openSummary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SummaryView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[TinderList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openSummary,
        tooltip: 'Open summary',
        child: const Icon(Icons.leaderboard_outlined),
      ),
    );
  }
}
