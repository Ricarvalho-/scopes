import '../../commons/progress_status.dart';
import '../../task/model/task.dart';
import '../../task/model/task_status.dart';

class Goal extends ProgressStatus {
  String title;
  DateTime deadline;
  final List<Task> tasks;

  Goal(this.title, this.deadline, this.tasks);

  DateTime highlightedDeadline() => deadline;

  bool isSelfDeadline() => true;

  double toDoPercent() => tasks.fold(
      0, (previousValue, task) => previousValue + 1 - task.progress()
  ) / tasks.length;

  double doingPercent() => _tasksAt(Status.doing).fold(
      0, (previousValue, task) => previousValue + task.progress()
  ) / tasks.length;

  double donePercent() =>
      _tasksAt(Status.done).length.toDouble() / tasks.length;

  Iterable<Task> _tasksAt(Status status) =>
      tasks.where((task) => task.status.isSameAs(status));
}
