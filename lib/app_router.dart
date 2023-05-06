import 'package:go_router/go_router.dart';
import 'package:todo_app/home_screen.dart';

enum AppRoute {
  home,
  todos,
}

extension AppRouteX on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.home:
        return 'home';
      case AppRoute.todos:
        return 'todos';
    }
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(title: 'Tvskrz'),
    ),
  ],
  debugLogDiagnostics: true,
);
