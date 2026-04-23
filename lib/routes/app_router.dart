import 'package:go_router/go_router.dart';
import '../views/home_view.dart';
import '../views/list_view.dart';
import '../views/detail_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      path: '/list/:endpoint',
      builder: (context, state) {
        final endpoint = state.pathParameters['endpoint']!;
        return ListViewScreen(endpoint: endpoint);
      },
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>? ?? {};
        return DetailView(data: data);
      },
    ),
  ],
);