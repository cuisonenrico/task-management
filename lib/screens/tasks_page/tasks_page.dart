import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/screens/tasks_page/dot_marker.dart';
import 'package:task_management/screens/tasks_page/task_tile.dart';
import 'package:task_management/state/task_state/task_model/task_model.dart';
import 'package:task_management/state/task_state/task_provider/task_provider.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> with AutomaticKeepAliveClientMixin {
  CalendarFormat _calendarFormat = CalendarFormat.week; // Start in week mode
  double _dragStartY = 0.0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  bool get wantKeepAlive => true;

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final provider = ref.watch(taskProvider);
    final tasks = provider?.tasks;
    // final notifier = ref.watch(taskProvider.notifier);

    // Event loader function to check if a day has events
    List<TaskModel> getTasksForDay(DateTime day) {
      final eventExists = tasks?.mapNotNull((task) {
        final taskDate = DateTime.utc(
          task.createdAt!.year,
          task.createdAt!.day,
          task.createdAt!.month,
        );
        final dayParsed = DateTime.utc(
          day.year,
          day.day,
          day.month,
        );
        return taskDate == dayParsed ? task : null;
      }).toList();
      return eventExists ?? [];
    }

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: GestureDetector(
        onVerticalDragStart: (details) {
          _dragStartY = details.globalPosition.dy;
        },
        onVerticalDragUpdate: (details) {
          double dragDistance = details.globalPosition.dy - _dragStartY;

          if (dragDistance > 100 && _calendarFormat != CalendarFormat.month) {
            // Swipe Down to Expand to Month View
            setState(() {
              _calendarFormat = CalendarFormat.month;
            });
          } else if (dragDistance < -100 && _calendarFormat != CalendarFormat.week) {
            // Swipe Up to Collapse to Week View
            setState(() {
              _calendarFormat = CalendarFormat.week;
            });
          }
        },
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                // ignore: inference_failure_on_instance_creation
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2022, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    headerVisible: false,
                    calendarFormat: _calendarFormat,
                    availableCalendarFormats: {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.week: 'Week',
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    eventLoader: (day) => getTasksForDay(day),
                    calendarBuilders: CalendarBuilders<TaskModel>(
                      markerBuilder: (context, date, events) {
                        if (events.isNotEmpty) {
                          return DotMarker(events);
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // getTasksForDay(_selectedDay ?? _focusedDay).isNotEmpty
            ...getTasksForDay(_selectedDay ?? _focusedDay).map((task) => TaskTile(task)),
          ],
        ),
      ),
    );
  }
}
