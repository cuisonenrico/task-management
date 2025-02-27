import 'package:flutter/material.dart';
import 'package:task_management/screens/widgets/custom_expansion_tile.dart';
import 'package:task_management/state/task_state/task_model/task_model.dart';
import 'package:task_management/utilities/extensions/color_ext.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task, {super.key});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    // final textColor = task.hexColor?.hexToColor().getTextColor;
    final textColor = Colors.indigoAccent.getTextColor;
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 16),
            Flexible(
              flex: 1,
              child: Icon(
                Icons.circle_outlined,
                size: 35,
              ),
            ),
            Spacer(),
            Flexible(
              flex: 12,
              child: CustomExpansionTile(
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  // color: task.hexColor?.hexToColor(),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                expandedChildren: [
                  Text(
                    task.createdAt.toString(),
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ],
                child: Column(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          task.title ?? '',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          task.description ?? '',
                          style: TextStyle(
                            color: textColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
