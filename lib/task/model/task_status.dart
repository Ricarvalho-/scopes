abstract class TaskStatus {
  final double progress;
  final Status status;

  static const TaskStatus _toDo = _ToDo();
  static const TaskStatus _done = _Done();

  factory TaskStatus.toDo() => _toDo;
  factory TaskStatus.doing(double progress) => _Doing(progress);
  factory TaskStatus.done() => _done;

  bool isSameAs(Status status) {
    switch (status) {
      case Status.toDo: return this is _ToDo;
      case Status.doing: return this is _Doing;
      case Status.done: return this is _Done;
      default: return false;
    }
  }

  const TaskStatus._internal(this.progress, this.status);
}

enum Status {
  toDo, doing, done
}

extension MirrorCheck on Status {
  bool isSameAs(TaskStatus status) => status.isSameAs(this);
}

class _ToDo extends TaskStatus {
  const _ToDo() : super._internal(0, Status.toDo);
}

class _Doing extends TaskStatus {
  const _Doing(double progress) : super._internal(progress, Status.doing);
}

class _Done extends TaskStatus {
  const _Done() : super._internal(1, Status.done);
}
