import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime getDayOfWeek(int dayOfw) {
    DateTime currentDate = DateTime.now();
    String currentDayOfW = DateFormat("EEE").format(currentDate);
    switch (currentDayOfW) {
      case "Sun":
        switch (dayOfw) {
          case 2:
            return currentDate.add(const Duration(days: -6));
          case 3:
            return currentDate.add(const Duration(days: -5));
          case 4:
            return currentDate.add(const Duration(days: -4));
          case 5:
            return currentDate.add(const Duration(days: -3));
          case 6:
            return currentDate.add(const Duration(days: -2));
          case 7:
            return currentDate.add(const Duration(days: -1));
          default:
            return currentDate;
        }
      case "Mon":
        switch (dayOfw) {
          case 3:
            return currentDate.add(const Duration(days: 1));
          case 4:
            return currentDate.add(const Duration(days: 2));
          case 5:
            return currentDate.add(const Duration(days: 3));
          case 6:
            return currentDate.add(const Duration(days: 4));
          case 7:
            return currentDate.add(const Duration(days: 5));
          case 8:
            return currentDate.add(const Duration(days: 6));
          default:
            return currentDate;
        }
      case "Tue":
        switch (dayOfw) {
          case 2:
            return currentDate.add(const Duration(days: -1));
          case 4:
            return currentDate.add(const Duration(days: 1));
          case 5:
            return currentDate.add(const Duration(days: 2));
          case 6:
            return currentDate.add(const Duration(days: 3));
          case 7:
            return currentDate.add(const Duration(days: 4));
          case 8:
            return currentDate.add(const Duration(days: 5));
          default:
            return currentDate;
        }
      case "Wed":
        switch (dayOfw) {
          case 2:
            return currentDate.add(const Duration(days: -2));
          case 3:
            return currentDate.add(const Duration(days: -1));
          case 5:
            return currentDate.add(const Duration(days: 1));
          case 6:
            return currentDate.add(const Duration(days: 2));
          case 7:
            return currentDate.add(const Duration(days: 3));
          case 8:
            return currentDate.add(const Duration(days: 4));
          default:
            return currentDate;
        }
      case "Thu":
        switch (dayOfw) {
          case 2:
            return currentDate.add(const Duration(days: -3));
          case 3:
            return currentDate.add(const Duration(days: -2));
          case 4:
            return currentDate.add(const Duration(days: -1));
          case 6:
            return currentDate.add(const Duration(days: 1));
          case 7:
            return currentDate.add(const Duration(days: 2));
          case 8:
            return currentDate.add(const Duration(days: 3));
          default:
            return currentDate;
        }
      case "Fri":
        switch (dayOfw) {
          case 2:
            return currentDate.add(const Duration(days: -4));
          case 3:
            return currentDate.add(const Duration(days: -3));
          case 4:
            return currentDate.add(const Duration(days: -2));
          case 5:
            return currentDate.add(const Duration(days: -1));
          case 7:
            return currentDate.add(const Duration(days: 1));
          case 8:
            return currentDate.add(const Duration(days: 2));
          default:
            return currentDate;
        }
      case "Sat":
        switch (dayOfw) {
          case 2:
            return currentDate.add(const Duration(days: -5));
          case 3:
            return currentDate.add(const Duration(days: -4));
          case 4:
            return currentDate.add(const Duration(days: -3));
          case 5:
            return currentDate.add(const Duration(days: -2));
          case 6:
            return currentDate.add(const Duration(days: -1));
          case 8:
            return currentDate.add(const Duration(days: 1));
          default:
            return currentDate;
        }
      default:
        return currentDate;
    }
  }

  static bool validateDateTime(int y, int m, int d) {
    if ((m == 1 ||
            m == 3 ||
            m == 5 ||
            m == 7 ||
            m == 8 ||
            m == 10 ||
            m == 12) &&
        d <= 31 &&
        d >= 0) {
      return true;
    } else if ((m == 4 || m == 6 || m == 9 || m == 11) && d <= 30 && d >= 0) {
      return true;
    } else if (m == 2) {
      if (y % 4 == 0 && d <= 29 && d >= 0) {
        return true;
      } else if (y % 4 != 0 && d <= 28 && d >= 0) {
        return true;
      }
    }
    return false;
  }
}
