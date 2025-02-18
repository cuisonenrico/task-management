import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/state/task_state/task_model/task_model.dart';
import 'package:task_management/state/task_state/task_provider/task_provider.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week; // Start in week mode
  double _dragStartY = 0.0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(taskProvider);
    final tasks = provider?.tasks;
    // final notifier = ref.watch(taskProvider.notifier);

    // Event loader function to check if a day has events
    List<TaskModel> getTasksForDay(DateTime day) {
      final eventExists = tasks?.mapNotNull((task) {
        final taskDate = DateTime.utc(
          task.date!.year,
          task.date!.day,
          task.date!.month,
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
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          bottom: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: events
                                .take(3) // Show up to 3 dots
                                .map((event) => Container(
                                      margin: EdgeInsets.symmetric(horizontal: 2),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red, // Event dot color
                                      ),
                                    ))
                                .toList(),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // getTasksForDay(_selectedDay ?? _focusedDay).isNotEmpty
            ...getTasksForDay(_selectedDay ?? _focusedDay).map(
              (task) => AnimatedSwitcher(
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
                      Flexible(
                        flex: 1,
                        child: Icon(
                          Icons.circle_notifications_outlined,
                          size: 45,
                        ),
                      ),
                      Spacer(),
                      Flexible(
                        flex: 10,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.date.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    task.title ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    task.description ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
