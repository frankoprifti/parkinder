import 'package:flutter/material.dart';

class SummaryProvider extends ChangeNotifier {
  final List<Map> _votes = [];
  List<Map> get votes => _votes;

  void vote(String type, Map data) {
    _votes.add({...data, "vote": type});
    notifyListeners();
  }
}
