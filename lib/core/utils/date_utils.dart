import 'package:intl/intl.dart';

// toDateFormatted(DateTime date){
//   DateFormat formatter = DateFormat("dd/MM/yyyy");
//  return formatter.format(date);
// }


extension DateFormat on DateTime{
  String get toFormattedDate=>'$day / $month / $year';
}