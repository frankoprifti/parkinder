import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parkinder/providers/summary_provider.dart';
import 'package:parkinder/queries/read_parking_lots.dart';
import 'package:parkinder/widgets/love_hate.dart';
import 'package:parkinder/widgets/tinder_card.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';

class TinderList extends StatefulWidget {
  const TinderList({super.key});

  @override
  State<TinderList> createState() => _TinderListState();
}

class _TinderListState extends State<TinderList> {
  int offset = 0;

  void likeAction(Map<String, dynamic> parkingLot, BuildContext context) {
    context.read<SummaryProvider>().vote('Like', parkingLot);
  }

  void nopeAction(Map<String, dynamic> parkingLot, BuildContext context) {
    context.read<SummaryProvider>().vote('Nope', parkingLot);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Query(
      options: QueryOptions(
        document: gql(readParkingLots),
        variables: {
          'limit': 5,
          'offset': offset,
        },
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        final List<SwipeItem> swipeItems = [];

        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading && offset == 0) {
          return const Text('Loading');
        }
        List? parkingLots = result.data?['getAllParkingLots'];
        if (parkingLots == null) {
          return const Text('No parking lots');
        }
        for (var i = 0; i < parkingLots.length; i++) {
          swipeItems.add(SwipeItem(likeAction: () {
            likeAction(parkingLots[i], context);
          }, nopeAction: () {
            nopeAction(parkingLots[i], context);
          }));
        }
        MatchEngine matchEngine = MatchEngine(swipeItems: swipeItems);

        return Column(
          children: [
            SizedBox(
              width: width,
              height: height * 0.6,
              child: SwipeCards(
                matchEngine: matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  final parkingLot = parkingLots[index];
                  if (index == parkingLots.length - 1) {
                    fetchMore!(FetchMoreOptions(
                      variables: {
                        'limit': 5,
                        'offset': offset + 5,
                      },
                      updateQuery: (previousResultData, fetchMoreResultData) {
                        final List<dynamic> lots = [
                          ...previousResultData?['getAllParkingLots']
                              as List<dynamic>,
                          ...fetchMoreResultData?['getAllParkingLots']
                              as List<dynamic>
                        ];
                        if (fetchMoreResultData?['getAllParkingLots'].length >
                            0) {
                          fetchMoreResultData?['getAllParkingLots'] = lots
                              .sublist(previousResultData?['getAllParkingLots']
                                      .length -
                                  2);
                        }
                        return fetchMoreResultData;
                      },
                    ));
                    offset = offset + 5;
                  }
                  return TinderCard(
                    id: parkingLot['id'],
                    image: parkingLot['image'],
                    name: parkingLot['name'] ?? '',
                    address: parkingLot['address'] ?? '',
                    liveDate: parkingLot['live_date'] ?? '',
                    size: parkingLot['size'] ?? '',
                    status: parkingLot['status'] ?? '',
                    type: parkingLot['type'] ?? '',
                  );
                },
                onStackFinished: () {},
                itemChanged: (SwipeItem item, int index) {},
                upSwipeAllowed: false,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: LoveHate(
                matchEngine: matchEngine,
              ),
            ),
          ],
        );
      },
    );
  }
}
