import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_management/setup_app.dart';
import 'package:task_management/state/app_state.dart';

Future<void> startApp() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final store = Store<AppState>(
        initialState: AppState.init(),
        actionObservers: [if (kDebugMode) Log.printer(formatter: Log.multiLineFormatter)],
      );

      runApp(
        StoreProvider<AppState>(
          store: store,
          child: const SetupApp(),
        ),
      );
    },
    (error, stack) async => {},
  );
}
