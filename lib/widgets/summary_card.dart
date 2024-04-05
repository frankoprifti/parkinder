import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final Map parkingLotWithVote;
  const SummaryCard({super.key, required this.parkingLotWithVote});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      front: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              parkingLotWithVote['image'],
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(58, 255, 255, 255),
              ),
              child: Icon(
                parkingLotWithVote['vote'] == 'Like'
                    ? Icons.favorite
                    : Icons.heart_broken,
                size: 50,
                color: parkingLotWithVote['vote'] == 'Like'
                    ? Colors.red
                    : Colors.blue,
              ),
            )
          ],
        ),
      ),
      back: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parkingLotWithVote['name'],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700),
                ),
                Text(
                  parkingLotWithVote['address'],
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Total spots: ${parkingLotWithVote['size']}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Type: ${parkingLotWithVote['type']}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Status: ${parkingLotWithVote['status']}",
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
