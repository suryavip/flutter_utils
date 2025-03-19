/*
https://github.com/suryavip/flutter_utils
version: 3
*/

import 'package:intl/intl.dart';

const _firstDayOfTheWeek = DateTime.monday;

class Date implements Comparable<Date> {
  final DateTime dateTime;

  /// A DateTime wrapper but completely ignore the time.
  /// Use case: comparing or grouping same day defined by [DateTime] that might
  /// have different time but still same day.
  const Date(this.dateTime);

  factory Date.fromYmd(int year, [int month = 1, int day = 1]) =>
      Date(DateTime(year, month, day));

  Date.now() : dateTime = DateTime.now();

  Date.parse(String str) : dateTime = DateTime.parse(str);

  @override
  operator ==(other) =>
      other is Date && other.dateTime.zeroTime == dateTime.zeroTime;

  @override
  int get hashCode => dateTime.zeroTime.hashCode;

  @override
  String toString() => DateFormat('yyyy-MM-dd').format(dateTime);

  operator >=(other) =>
      other is Date &&
      (this > other || dateTime.zeroTime == other.dateTime.zeroTime);

  operator <=(other) =>
      other is Date &&
      (this < other || dateTime.zeroTime == other.dateTime.zeroTime);

  operator >(other) =>
      other is Date && dateTime.zeroTime.isAfter(other.dateTime.zeroTime);

  operator <(other) =>
      other is Date && dateTime.zeroTime.isBefore(other.dateTime.zeroTime);

  Date get nextDay => Date(dateTime.add(const Duration(days: 1)));
  Date get previousDay => Date(dateTime.subtract(const Duration(days: 1)));

  int get year => dateTime.year;
  int get month => dateTime.month;
  int get day => dateTime.day;

  Date get startOfTheMonth => Date.fromYmd(year, month);
  Date get endOfTheMonth => Date.fromYmd(year, month + 1).previousDay;

  @override
  int compareTo(Date other) =>
      dateTime.zeroTime.compareTo(other.dateTime.zeroTime);
}

extension ZeroTime on DateTime {
  /// Returns the same date but at 0 [hour], [minute], [second], ...
  DateTime get zeroTime => DateTime(year, month, day);

  /// Subtract 1 day until [weekday] matched with [_firstDayOfTheWeek].
  ///
  /// Example: current [day] is 29 and current [weekday] is [DateTime.tuesday].
  /// If [kFirstDayOfTheWeek] is [DateTime.monday] then will return previous day ([day] is 28 and [weekday] is [DateTime.monday]).
  DateTime get previousFirstDayOfTheWeek {
    DateTime start = this;
    while (start.weekday != _firstDayOfTheWeek) {
      start = start.subtract(const Duration(days: 1));
    }
    return start;
  }

  /// Add 1 day until [weekday] matched with [_firstDayOfTheWeek] - 1 day.
  ///
  /// Example: current [day] is 2 and current [weekday] is [DateTime.friday].
  /// If [kFirstDayOfTheWeek] is [DateTime.monday] then will return :([day] : 4 and [weekday] is [DateTime.sunday]).
  DateTime get nextLastDayOfTheWeek {
    DateTime start = this;
    do {
      start = start.add(const Duration(days: 1));
    } while (start.weekday != _firstDayOfTheWeek);
    return start.subtract(const Duration(days: 1));
  }
}
