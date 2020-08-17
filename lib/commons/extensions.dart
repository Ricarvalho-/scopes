import 'package:intl/intl.dart';

extension SafeAccess<E> on Iterable<E> {
  E get firstOrNull => isNotEmpty ? first : null;
}

extension Conditional<E> on Iterable<E> {
  Iterable<E> followedByIf(bool condition, Iterable<E> other) {
    if (condition) return this.followedBy(other);
    return this;
  }
}

extension Percent on double {
  String toStringAsPercent([int fractionDigits = 0]) =>
      "${(this * 100).toStringAsFixed(fractionDigits)}%";
}

extension Format on DateTime {
  String prettyFormatted() => DateFormat.yMEd().format(this);
}