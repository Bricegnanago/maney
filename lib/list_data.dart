import 'package:intl/intl.dart';
// import 'package:maney/models/DbManager.dart';
// import 'dart:ui' show lerpDouble;
main() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  var date = DateTime.parse('1974-03-20 00:00:00.000');
  var dateFormatted = formatter.format(date);

  var date2 = DateTime.parse('1974-03-21 00:00:00.000');
  var date2Formatted = formatter.format(date2);
  // print(date.runtimeType);
  print(date2Formatted);
  print(dateFormatted);
  // DbUserManager dbUserManager = DbUserManager();

  // dbUserManager.getListuser().then((value) => print(value));
}