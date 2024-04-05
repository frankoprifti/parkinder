import 'package:flutter/material.dart';
import 'package:parkinder/providers/summary_provider.dart';
import 'package:parkinder/widgets/summary_card.dart';
import 'package:provider/provider.dart';

class SummaryView extends StatefulWidget {
  const SummaryView({super.key});

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  String selectedFilter = '';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Map> rawVotes = context.read<SummaryProvider>().votes;
    List<Map> filteredVotes = rawVotes.where((element) {
      if (selectedFilter.isNotEmpty && element['vote'] != selectedFilter) {
        return false;
      }
      String searchTerm = searchController.text.toLowerCase();
      if (searchTerm.isNotEmpty &&
          (!element['name']
                  .toString()
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) &&
              !element['address']
                  .toString()
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()))) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Summary view'),
      ),
      body: rawVotes.isEmpty
          ? const Center(
              child: Text('No activity yet'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          decoration: const InputDecoration(
                              hintText: 'Search parking lots'),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedFilter =
                                selectedFilter == 'Nope' ? '' : 'Nope';
                          });
                        },
                        icon: Icon(
                          Icons.heart_broken,
                          color: Colors.blue
                              .withOpacity(selectedFilter == 'Nope' ? 1 : 0.3),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedFilter =
                                selectedFilter == 'Like' ? '' : 'Like';
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red
                              .withOpacity(selectedFilter == 'Like' ? 1 : 0.3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1.2,
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                      itemCount: filteredVotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SummaryCard(
                          parkingLotWithVote: filteredVotes[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
