import 'package:intl/intl.dart';

import 'package:bibcujae/src/shared/constants/constants.dart';

/// Class that contains util methods to parse the response of the
/// backend
class ParserUtils{
  /// Method that allows to format an back received date.
  // static DateTime parseBackDate(String utcDateToFormat){
  //   return DateFormat(Constants.BACK_DATE_FORMAT).parseUtc(utcDateToFormat).toLocal();
  // }

  /// Method that allows to convert a date to a string
  /// in the format dd-MM-yyyy
  static String parseDate(String dateToConvert) {
    DateTime dateTime = DateTime.parse(dateToConvert);
    String dateTimeParsed = DateFormat('dd/MM/yyyy').format(dateTime);
    return dateTimeParsed;
  }

 
}