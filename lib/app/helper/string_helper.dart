class StringHelper {
  static String replaceSpecialChars(value) {
    return value.replaceAll(RegExp('[^A-Za-z0-9 ]'), '');
  }
}
