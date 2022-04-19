class DateTimeUtils {
  static String getDaysAgo(String isoTime) {
    final now = DateTime.now();
    final dateObj = DateTime.parse(isoTime);
    final daysAgo = now.subtract(Duration(days: dateObj.day));
    return daysAgo.day.toString();
  }
}
