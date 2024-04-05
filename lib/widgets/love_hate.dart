import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class LoveHate extends StatelessWidget {
  final MatchEngine matchEngine;
  const LoveHate({super.key, required this.matchEngine});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            matchEngine.currentItem!.nope();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(60)),
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(
                Icons.heart_broken,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            matchEngine.currentItem!.like();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(60)),
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
