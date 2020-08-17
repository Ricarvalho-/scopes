import 'package:flutter/material.dart';
import 'package:scopes/commons/progress_bar.dart';
import 'package:scopes/commons/progress_section.dart';

import '../commons/extensions.dart';
import 'progress_status.dart';

class ProgressStatusItem extends StatelessWidget {
  final ProgressStatus status;
  final Function onTap;

  ProgressStatusItem({
    Key key,
    this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(status.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[]
            .followedByIf(
              status.isSelfDeadline && status.highlightedDeadline != null,
              () => [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text("${status.highlightedDeadline.prettyFormatted()}"),
                ),
              ],
              elseOther: () => [
                SizedBox(
                  height: status.containsTasks ? 8 : 0,
                )
              ],
            )
            .followedByIf(
                status.containsTasks,
                () => [
                      ProgressBar(
                        sections: [
                          ProgressSection(
                            "Done",
                            status.donePercent,
                            Colors.green,
                          ),
                          ProgressSection(
                            "Doing",
                            status.doingPercent,
                            Colors.yellow,
                          ),
                          ProgressSection(
                            "To Do",
                            status.toDoPercent,
                            Colors.red,
                          ),
                        ],
                      ),
                    ])
            .toList(),
      ),
      onTap: onTap,
    );
  }
}
