import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:task_management/screens/main_page/main_page.dart';
import 'package:task_management/state/user_state/user_provider/user_provider.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    observers: [routeObservers],
    initialLocation: MainPage.route,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: MainPage.route,
        name: MainPage.routeName,
        builder: (_, state) => const MainPage(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const MainPage(),
        ),
        redirect: (_, __) {
          ref.read(userProvider.notifier).getUser('YHSczIKk2tQj4pzCNgm1rvvDGu52');

          return null;
        },
        routes: const [],
      ),
    ],
  ),
);

// Register the RouteObserver as a navigation observer.
final RouteObserver<ModalRoute<void>> routeObservers = RouteObserver<ModalRoute<void>>();

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child),
    );
