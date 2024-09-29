import 'package:dicoding_voiceapp/features/auth/presentation/pages/auth_page.dart';
import 'package:go_router/go_router.dart';

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
    ],
  );
}
