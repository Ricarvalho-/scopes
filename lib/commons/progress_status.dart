abstract class ProgressStatus {
  String get title;
  DateTime get highlightedDeadline;
  bool get isSelfDeadline;
  bool get containsTasks;
  double get toDoPercent;
  double get doingPercent;
  double get donePercent;
}