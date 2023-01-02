class FormatString {
  static String formatDateString(String date) {
    if (date.isEmpty) return '10/10/2010';
    var splitedString = date.substring(0, 10).split('-').reversed;
    var formatDateString = splitedString
        .toString()
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(', ', '/');

    return formatDateString;
  }
}
