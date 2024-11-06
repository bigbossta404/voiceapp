import 'package:dicoding_voiceapp/features/auth/pages/auth_page.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/pages/register_page.dart';
import '../features/home/pages/home_page.dart';
import '../helper/router_index.dart';

// GoRouter configuration
class AppRouterConfig {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        name: RouterIndex.auth,
        path: '/',
        builder: (context, GoRouterState state) {
          return const AuthPage();
        },
      ),
      GoRoute(
        name: RouterIndex.register,
        path: '/${RouterIndex.register}',
        builder: (context, GoRouterState state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        name: RouterIndex.homePage,
        path: '/${RouterIndex.homePage}',
        builder: (context, GoRouterState state) {
          return const HomePage();
        },
      ),
    ],
  );
}
