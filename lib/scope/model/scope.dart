import '../../commons/extensions.dart';
import '../../commons/progress_status.dart';
import '../../goal/model/goal.dart';
import '../../task/model/task.dart';
import '../../task/model/task_status.dart';

class Scope extends ProgressStatus {
  @override
  String title;
  final List<Goal> goals;

  Scope(this.title, this.goals);

  @override
  DateTime get highlightedDeadline => (
      goals.where((goal) => goal.deadline != null).where(
              (goal) => !goal.tasks.every(
                      (task) => task.status.isSameAs(Status.done)
              ) || goal.tasks.isEmpty
      ).map((goal) => goal.deadline).toList()..sort()
  ).firstOrNull;

  @override
  bool get isSelfDeadline => false;

  @override
  bool get containsTasks => _allGoalsTasks().isNotEmpty;

  @override
  double get toDoPercent => _percentOf(Status.toDo);

  @override
  double get doingPercent => _percentOf(Status.doing);

  @override
  double get donePercent => _percentOf(Status.done);

  double _percentOf(Status status) =>
      Goal(null, null, _allGoalsTasks())._percentOf(status);

  List<Task> _allGoalsTasks() =>
      goals.fold(List<Task>(), (list, goal) => list..addAll(goal.tasks));
}

extension Percent on Goal {
  double _percentOf(Status status) {
    switch (status) {
      case Status.toDo: return toDoPercent;
      case Status.doing: return doingPercent;
      case Status.done: return donePercent;
      default: return 0;
    }
  }
}