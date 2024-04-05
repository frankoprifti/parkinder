import 'package:flutter/material.dart';

class TinderCard extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final String address;
  final String liveDate;
  final int size;
  final String status;
  final String type;

  const TinderCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.address,
    required this.liveDate,
    required this.size,
    required this.status,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: const Color(0xa8a8a8).withOpacity(1),
            offset: const Offset(0, 5),
            blurRadius: 7,
            spreadRadius: 0,
          )
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                image,
                height: height,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.only(top: 50),
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 255, 255, 255),
                      Color(0xffffffff)
                    ],
                    stops: [-1, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width - 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(fontSize: 25),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "($type)",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Text(
                              address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "$size spots",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(color: Colors.white, width: 4),
                          color: status == 'active' ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
