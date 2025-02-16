import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management/utilities/app_router.dart';

class TaskManagementApp extends ConsumerWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Task Management App',
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.system, // Follows system settings
      routeInformationProvider: ref.read(routerProvider).routeInformationProvider,
      routeInformationParser: ref.read(routerProvider).routeInformationParser,
      routerDelegate: ref.read(routerProvider).routerDelegate,
    );
  }
}
