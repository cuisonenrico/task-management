import 'package:flutter/material.dart';
import 'package:task_management/state/task_state/task_model/task_model.dart';
import 'package:task_management/utilities/extensions/color_ext.dart';

class DotMarker extends StatelessWidget {
  const DotMarker(this.events, {super.key});

  final List<TaskModel> events;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: events
          .take(3) // Show up to 3 dots
          .map(
            (event) => Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: event.hexColor?.hexToColor(), // Event dot color
              ),
            ),
          )
          .toList(),
    );
  }
}
