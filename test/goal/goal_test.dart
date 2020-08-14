import 'package:flutter_test/flutter_test.dart';
import 'package:scopes/goal/model/goal.dart';
import 'package:scopes/task/model/task.dart';
import 'package:scopes/task/model/task_status.dart';

void main() {
  group("Status percents", () {
    group("To Do percents", () {
      test("Alone should fill self percent", () {
        final goal = _dummyGoal([
          TaskStatus.toDo(),
        ]);

        expect(goal.toDoPercent(), 1);
        expect(goal.doingPercent(), 0);
        expect(goal.donePercent(), 0);
      });
    });

    group("Doing percents", () {
      test("Alone and full should fill self percent", () {
        final goal = _dummyGoal([
          TaskStatus.doing(1),
        ]);

        expect(goal.toDoPercent(), 0);
        expect(goal.doingPercent(), 1);
        expect(goal.donePercent(), 0);
      });

      test("Alone but empty should fill To Do percent", () {
        final goal = _dummyGoal([
          TaskStatus.doing(0.5),
        ]);

        expect(goal.toDoPercent(), 0.5);
        expect(goal.doingPercent(), 0.5);
        expect(goal.donePercent(), 0);
      });

      test("Alone but incomplete should share percent with To Do", () {
        final goal = _dummyGoal([
          TaskStatus.doing(0.7),
        ]);

        expect(goal.toDoPercent(), closeTo(0.3, 0.001));
        expect(goal.doingPercent(), closeTo(0.7, 0.001));
        expect(goal.donePercent(), 0);
      });
    });

    group("Done percents", () {
      test("Alone should fill self percent", () {
        final goal = _dummyGoal([
          TaskStatus.done(),
        ]);

        expect(goal.toDoPercent(), 0);
        expect(goal.doingPercent(), 0);
        expect(goal.donePercent(), 1);
      });
    });

    group("Mixed percents", () {
      test("Mixed states should honor percentage sharing", () {
        final goal = _dummyGoal([
          TaskStatus.toDo(),
          TaskStatus.doing(0.2),
          TaskStatus.doing(0.5),
          TaskStatus.done(),
        ]);

        expect(goal.toDoPercent(), closeTo(0.575, 0.001));
        expect(goal.doingPercent(), closeTo(0.175, 0.001));
        expect(goal.donePercent(), closeTo(0.25, 0.001));
      });
    });
  });
}

Goal _dummyGoal(List<TaskStatus> status) => Goal(
      null,
      null,
      status.map((it) => Task(null, it)).toList(),
    );
