abstract class ProgressStatus {
  String title;
  DateTime highlightedDeadline();
  double toDoPercent();
  double doingPercent();
  double donePercent();
}