abstract class ProgressStatus {
  String title;
  DateTime highlightedDeadline();
  bool isSelfDeadline();
  double toDoPercent();
  double doingPercent();
  double donePercent();
}