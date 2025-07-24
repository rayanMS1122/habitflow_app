import 'package:intl/intl.dart';

class DateHelper {
  static const List<String> weekdayNames = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  static const List<String> weekdayShortNames = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

  static const List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> monthShortNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  /// Returns the current date without time
  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Returns yesterday's date
  static DateTime get yesterday {
    return today.subtract(const Duration(days: 1));
  }

  /// Returns tomorrow's date
  static DateTime get tomorrow {
    return today.add(const Duration(days: 1));
  }

  /// Checks if two dates are the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  /// Checks if a date is today
  static bool isToday(DateTime date) {
    return isSameDay(date, today);
  }

  /// Checks if a date is yesterday
  static bool isYesterday(DateTime date) {
    return isSameDay(date, yesterday);
  }

  /// Checks if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    return isSameDay(date, tomorrow);
  }

  /// Returns the start of the week (Monday) for a given date
  static DateTime getStartOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }

  /// Returns the end of the week (Sunday) for a given date
  static DateTime getEndOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.add(Duration(days: 7 - weekday));
  }

  /// Returns the start of the month for a given date
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Returns the end of the month for a given date
  static DateTime getEndOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  /// Returns the start of the year for a given date
  static DateTime getStartOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }

  /// Returns the end of the year for a given date
  static DateTime getEndOfYear(DateTime date) {
    return DateTime(date.year, 12, 31);
  }

  /// Returns the number of days in a month
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  /// Returns the number of days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inDays;
  }

  /// Returns a list of dates between two dates (inclusive)
  static List<DateTime> getDateRange(DateTime start, DateTime end) {
    final dates = <DateTime>[];
    var current = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);

    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      dates.add(current);
      current = current.add(const Duration(days: 1));
    }

    return dates;
  }

  /// Returns the last N days from today (including today)
  static List<DateTime> getLastNDays(int n) {
    final dates = <DateTime>[];
    for (int i = n - 1; i >= 0; i--) {
      dates.add(today.subtract(Duration(days: i)));
    }
    return dates;
  }

  /// Returns the next N days from today (including today)
  static List<DateTime> getNextNDays(int n) {
    final dates = <DateTime>[];
    for (int i = 0; i < n; i++) {
      dates.add(today.add(Duration(days: i)));
    }
    return dates;
  }

  /// Formats a date as a string
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(date);
  }

  /// Formats a date for display
  static String formatDateForDisplay(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    } else if (isTomorrow(date)) {
      return 'Tomorrow';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  /// Formats a date as a relative string (e.g., "2 days ago")
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        } else {
          return '${difference.inMinutes}m ago';
        }
      } else {
        return '${difference.inHours}h ago';
      }
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  }

  /// Formats time as a string
  static String formatTime(DateTime time, {bool use24Hour = false}) {
    if (use24Hour) {
      return DateFormat('HH:mm').format(time);
    } else {
      return DateFormat('h:mm a').format(time);
    }
  }

  /// Parses a date string
  static DateTime? parseDate(String dateString, {String pattern = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(pattern).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Returns the weekday name for a given date
  static String getWeekdayName(DateTime date, {bool short = false}) {
    final weekday = date.weekday - 1; // Convert to 0-based index
    return short ? weekdayShortNames[weekday] : weekdayNames[weekday];
  }

  /// Returns the month name for a given date
  static String getMonthName(DateTime date, {bool short = false}) {
    final month = date.month - 1; // Convert to 0-based index
    return short ? monthShortNames[month] : monthNames[month];
  }

  /// Checks if a year is a leap year
  static bool isLeapYear(int year) {
    return (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
  }

  /// Returns the age in years from a birth date
  static int getAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    
    return age;
  }

  /// Returns the first day of the week for a given date
  static DateTime getFirstDayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// Returns the last day of the week for a given date
  static DateTime getLastDayOfWeek(DateTime date) {
    return date.add(Duration(days: 7 - date.weekday));
  }

  /// Checks if a date is in the current week
  static bool isInCurrentWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = getFirstDayOfWeek(now);
    final endOfWeek = getLastDayOfWeek(now);
    
    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
           date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Checks if a date is in the current month
  static bool isInCurrentMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Checks if a date is in the current year
  static bool isInCurrentYear(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year;
  }

  /// Returns a DateTime for the next occurrence of a specific weekday
  static DateTime getNextWeekday(int weekday) {
    final now = DateTime.now();
    final daysUntilWeekday = (weekday - now.weekday) % 7;
    final daysToAdd = daysUntilWeekday == 0 ? 7 : daysUntilWeekday;
    return now.add(Duration(days: daysToAdd));
  }

  /// Returns the quarter of the year for a given date (1-4)
  static int getQuarter(DateTime date) {
    return ((date.month - 1) / 3).floor() + 1;
  }

  /// Returns the week number of the year for a given date
  static int getWeekOfYear(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final dayOfYear = date.difference(startOfYear).inDays + 1;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
}

