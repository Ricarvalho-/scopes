import '../../commons/progress_status.dart';
import '../../task/model/task.dart';
import '../../task/model/task_status.dart';

class Goal extends ProgressStatus {
  @override
  String title;
  DateTime deadline;
  final List<Task> tasks;

  Goal(this.title, this.deadline, this.tasks);

  @override
  DateTime get highlightedDeadline => deadline;

  @override
  bool get isSelfDeadline => true;

  @override
  bool get containsTasks => tasks.isNotEmpty;

  @override
  double get toDoPercent => tasks.fold(
      0, (previousValue, task) => previousValue + 1 - task.progress
  ) / tasks.length;

  @override
  double get doingPercent => _tasksAt(Status.doing).fold(
      0, (previousValue, task) => previousValue + task.progress
  ) / tasks.length;

  @override
  double get donePercent =>
      _tasksAt(Status.done).length.toDouble() / tasks.length;

  Iterable<Task> _tasksAt(Status status) =>
      tasks.where((task) => task.status.isSameAs(status));
}
