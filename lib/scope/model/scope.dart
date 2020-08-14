import '../../commons/extensions.dart';
import '../../commons/progress_status.dart';
import '../../goal/model/goal.dart';
import '../../task/model/task_status.dart';

class Scope extends ProgressStatus {
  String title;
  final List<Goal> goals;

  Scope(this.title, this.goals);

  DateTime highlightedDeadline() => (
      goals.where((goal) => goal.tasks
          .every((task) => !task.status.isSameAs(Status.done))
      ).map((goal) => goal.deadline)
          .toList()..sort()
  ).firstOrNull();

  double toDoPercent() => _percentOf(Status.toDo);

  double doingPercent() => _percentOf(Status.doing);

  double donePercent() => _percentOf(Status.done);

  double _percentOf(Status status) => goals.fold(
      0, (previousValue, goal) => previousValue + goal._percentOf(status)
  ) / goals.length;
}

extension Percent on Goal {
  double _percentOf(Status status) {
    switch (status) {
      case Status.toDo: return toDoPercent();
      case Status.doing: return doingPercent();
      case Status.done: return donePercent();
      default: return 0;
    }
  }
}