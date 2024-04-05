import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parkinder/providers/summary_provider.dart';
import 'package:parkinder/screens/home_page.dart';
import 'package:provider/provider.dart';

final HttpLink link = HttpLink(
  'https://interview-apixx07.dev.park-depot.de/',
);
void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SummaryProvider(),
      child: Consumer<SummaryProvider>(
        builder: (context, values, child) {
          return GraphQLProvider(
              client: client,
              child: MaterialApp(
                title: 'Parktinder',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: const Color(0xff054cda)),
                  useMaterial3: true,
                ),
                home: const HomePage(title: 'Parkinder'),
              ));
        },
      ),
    );
  }
}
