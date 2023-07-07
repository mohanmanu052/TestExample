import 'package:intl/intl.dart';

class ParseDate {
  static String parseDob(DateTime data) {
    String date = '';
    String formattedDate = DateFormat('dd-MM-yyyy').format(data);

    return formattedDate;
  }

  static String calculateNumberOfdays(DateTime data) {
    final date2 = DateTime.now();
    final difference = date2.difference(data).inDays;
    return difference.toString();
  }
}
