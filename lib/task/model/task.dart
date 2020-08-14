import 'task_status.dart';

class Task {
  String title;
  TaskStatus status;

  Task(this.title, this.status);

  double progress() => status.progress;
}