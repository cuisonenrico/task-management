import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management/firebase_options.dart';
import 'package:task_management/state/user_state/user_model/user_model.dart';
import 'package:task_management/task_management_app.dart';

Future<void> startApp() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Hive.initFlutter();
      // Register the User adapter
      Hive.registerAdapter(UserModelImplAdapter());

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      final currUser = FirebaseAuth.instance.currentUser;

      // if (currUser != null) await store.dispatch(UserLoginAction(currUser));

      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user != null && user.uid != currUser?.uid) {
          // await store.dispatch(UserLoginAction(user));
        }
      });

      runApp(
        ProviderScope(child: TaskManagementApp()),
      );
    },
    (error, stack) async => {},
  );
}
