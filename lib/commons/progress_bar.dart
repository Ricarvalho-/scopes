import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'progress_section.dart';

class ProgressBar extends StatelessWidget {
  final List<ProgressSection> sections;

  ProgressBar({
    Key key,
    this.sections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath.shape(
      shape: StadiumBorder(),
      child: Row(
        children: sections
            .where((section) => section._normalizedWeight > 0)
            .map(
              (section) => Flexible(
                flex: (section.weight * 100).round(),
                child: Container(
                  color: section.color,
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "${section._normalizedWeight}%",
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
//              flex: (section.weight * 100).round(),
//              child: Container(
//                height: 20,
//                color: section.color,
//                padding: EdgeInsets.all(8),
//                child: Center(
//                  child: Text(section.title),
//                ),
//              ),
//            ),
            )
            .toList(),
      ),
    );
  }
}

extension Normalized on ProgressSection {
  int get _normalizedWeight => (weight * 100).round();
}
