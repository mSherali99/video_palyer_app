import 'package:intl/intl.dart';

extension TimeExtention on String{
  String getTimeAgo() {
    String inputDate = this;
    print("input data = ==== =$inputDate");
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    try {
      DateTime parsedDate = dateFormat.parse(inputDate);
      DateTime currentDate = DateTime.now();

      int years = currentDate.year - parsedDate.year;
      int months = currentDate.month - parsedDate.month;
      int days = currentDate.day - parsedDate.day;

      if (days < 0) {
        months--;
        days += DateTime(currentDate.year, currentDate.month - 1, 0).day;
      }
      if (months < 0) {
        years--;
        months += 12;
      }

      String result = "";
      if (years > 0) {
        result += "$years year ";
      }
      if (months > 0) {
        result += "$months month ";
      }
      if (days > 0) {
        result += "$days day";
      }
      return result;
    } catch (e) {
      return 'Wrong format';
    }
  }

}