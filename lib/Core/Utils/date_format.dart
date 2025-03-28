import 'package:intl/intl.dart';

String dateFormatDMMMYYYY(DateTime datetime) {
  return DateFormat('d MMM yyyy').format(datetime);
}
