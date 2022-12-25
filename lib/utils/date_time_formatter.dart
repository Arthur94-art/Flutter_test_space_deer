import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String getDate(DateTime date) {
    return DateFormat.yMEd().add_jms().format(date);
  }
}
