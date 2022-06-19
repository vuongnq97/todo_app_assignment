part of 'enums.dart';

abstract class CategoryTask {
  static const int home = 1;
  static const int work = 2;
  static const int personal = 3;

  static getName(int type) {
    if (home == type) {
      return "Home";
    } else if (work == type) {
      return "Work";
    } else {
      return "Personal";
    }
  }
}
