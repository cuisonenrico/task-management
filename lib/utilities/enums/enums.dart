import 'package:flutter/material.dart';

enum TaskStatus {
  HIGH(Colors.redAccent),
  MEDIUM(Colors.yellowAccent),
  LOW(Colors.greenAccent);

  const TaskStatus(this.color);
  final Color color;
}
