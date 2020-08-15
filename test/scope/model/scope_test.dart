import 'package:flutter_test/flutter_test.dart';
import 'package:scopes/goal/model/goal.dart';
import 'package:scopes/scope/model/scope.dart';
import 'package:scopes/task/model/task.dart';
import 'package:scopes/task/model/task_status.dart';

void main() {
  group("All tests", () {
    group("Highlighted deadlines", () {
      final now = DateTime.now();

      group("Status filtering", () {
        test("Empty should be considered", () {
          final scope = _dummyScopeForDeadlines({
            now : [],
          });

          expect(scope.highlightedDeadline(), now);
        });

        test("To Do should be considered", () {
          final scope = _dummyScopeForDeadlines({
            now : [TaskStatus.toDo()],
          });

          expect(scope.highlightedDeadline(), now);
        });

        test("Doing should be considered", () {
          final scope = _dummyScopeForDeadlines({
            now : [TaskStatus.doing(0)],
          });

          expect(scope.highlightedDeadline(), now);
        });

        test("Done should be disregarded", () {
          final scope = _dummyScopeForDeadlines({
            now : [TaskStatus.done()],
          });

          expect(scope.highlightedDeadline(), null);
        });

        test("To Do should appear even when beside a Done", () {
          final scope = _dummyScopeForDeadlines({
            now : [
              TaskStatus.toDo(),
              TaskStatus.done(),
            ],
          });

          expect(scope.highlightedDeadline(), now);
        });

        test("Doing should appear even when beside a Done", () {
          final scope = _dummyScopeForDeadlines({
            now : [
              TaskStatus.doing(0),
              TaskStatus.done(),
            ],
          });

          expect(scope.highlightedDeadline(), now);
        });
      });

      group("Selection order", () {
        test("First of two dates should be selected", () {
          final tomorrow = now.add(Duration(days: 1));
          final scope = _dummyScopeForDeadlines({
            now : [TaskStatus.toDo()],
            tomorrow : [TaskStatus.toDo()],
          });

          expect(scope.highlightedDeadline(), now);
        });

        test("First of two dates should be selected even if out of order", () {
          final tomorrow = now.add(Duration(days: 1));
          final scope = _dummyScopeForDeadlines({
            tomorrow : [TaskStatus.toDo()],
            now : [TaskStatus.toDo()],
          });

          expect(scope.highlightedDeadline(), now);
        });

        test("First should be selected even if past date", () {
          final yesterday = now.subtract(Duration(days: 1));
          final scope = _dummyScopeForDeadlines({
            yesterday : [TaskStatus.toDo()],
            now : [TaskStatus.toDo()],
          });

          expect(scope.highlightedDeadline(), yesterday);
        });

        test("First should be selected even if in future date", () {
          final tomorrow = now.add(Duration(days: 1));
          final afterTomorrow = now.add(Duration(days: 2));
          final scope = _dummyScopeForDeadlines({
            tomorrow : [TaskStatus.toDo()],
            afterTomorrow : [TaskStatus.toDo()],
          });

          expect(scope.highlightedDeadline(), tomorrow);
        });
      });
    });

    group("Status percents", () {
      group("To Do percents", () {
        test("Alone should fill self percent", () {
          final scope = _dummyScopeForStatus([
            [
              TaskStatus.toDo(),
            ],
            [
              TaskStatus.toDo(),
            ],
          ]);

          expect(scope.toDoPercent(), 1);
          expect(scope.doingPercent(), 0);
          expect(scope.donePercent(), 0);
        });
      });

      group("Doing percents", () {
        test("Alone and full should fill self percent", () {
          final scope = _dummyScopeForStatus([
            [
              TaskStatus.doing(1),
            ],
            [
              TaskStatus.doing(1),
            ],
          ]);

          expect(scope.toDoPercent(), 0);
          expect(scope.doingPercent(), 1);
          expect(scope.donePercent(), 0);
        });

        test("Alone but empty should fill To Do percent", () {
          final scope = _dummyScopeForStatus([
            [
              TaskStatus.doing(0),
            ],
            [
              TaskStatus.doing(0),
            ],
          ]);

          expect(scope.toDoPercent(), 1);
          expect(scope.doingPercent(), 0);
          expect(scope.donePercent(), 0);
        });

        test("Alone but incomplete should share percent with To Do", () {
          final scope = _dummyScopeForStatus([
            [
              TaskStatus.doing(0.5),
            ],
            [
              TaskStatus.doing(0.7),
            ],
          ]);

          expect(scope.toDoPercent(), closeTo(0.4, 0.001));
          expect(scope.doingPercent(), closeTo(0.6, 0.001));
          expect(scope.donePercent(), 0);
        });
      });

      group("Done percents", () {
        test("Alone should fill self percent", () {
          final scope = _dummyScopeForStatus([
            [
              TaskStatus.done(),
            ],
            [
              TaskStatus.done(),
            ],
          ]);

          expect(scope.toDoPercent(), 0);
          expect(scope.doingPercent(), 0);
          expect(scope.donePercent(), 1);
        });
      });

      group("Mixed percents", () {
        test("Mixed states should honor percentage sharing", () {
          final scope = _dummyScopeForStatus([
            [
              TaskStatus.toDo(),
              TaskStatus.doing(0.2),
              TaskStatus.doing(0.5),
              TaskStatus.done(),
            ],
            [
              TaskStatus.toDo(),
              TaskStatus.doing(0.2),
              TaskStatus.done(),
            ],
          ]);

          expect(scope.toDoPercent(), closeTo(0.5875, 0.001));
          expect(scope.doingPercent(), closeTo(0.1208, 0.001));
          expect(scope.donePercent(), closeTo(0.2916, 0.001));
        });
      });
    });
  });
}

Scope _dummyScopeForDeadlines(Map<DateTime, List<TaskStatus>> items) => Scope(
      null,
      items.entries.map((item) => _dummyGoal(item.value, item.key)).toList(),
    );

Scope _dummyScopeForStatus(List<List<TaskStatus>> status) => Scope(
      null,
      status.map((it) => _dummyGoal(it)).toList(),
    );

Goal _dummyGoal(List<TaskStatus> status, [DateTime deadline]) => Goal(
      null,
      deadline,
      status.map((it) => Task(null, it)).toList(),
    );
