import 'package:flutter/cupertino.dart';

class HomePageProvider with ChangeNotifier {
  String _filter = 'All';
  String get filter => _filter;

  String _date = DateTime.now().formatDate();

  String get date => _date;

  changeFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  changeDate(DateTime date) {
    _date = date.formatDate();
    notifyListeners();
  }
}

extension FormatDate on DateTime {
  String formatDate() {
    return '$year-$month-$day';
  }
}

extension DateTimeParse on String {
  DateTime dateTimeParse() {
    List<String> date = split('-');
    var year = date[0];
    var month = int.parse(date[1]) < 10 ? '0${date[1]}' : date[1];
    var day = int.parse(date[2]) < 10 ? '0${date[1]}' : date[1];
    return DateTime.parse('$year-$month-$day');
  }
}
