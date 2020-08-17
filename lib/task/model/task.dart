import 'task_status.dart';

class Task {
  String title;
  TaskStatus status;

  Task(this.title, this.status);

  double get progress => status.progress;
}