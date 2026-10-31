import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/shell/presentation/app_shell.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/placeholder_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: '/', builder: (_, __) => const HomeScreen())],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, _) => PlaceholderScreen(
                title: AppLocalizations.of(context)!.navCategories,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, _) => PlaceholderScreen(
                title: AppLocalizations.of(context)!.navSettings,
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/add',
      builder: (context, _) => Scaffold(
        body: PlaceholderScreen(title: AppLocalizations.of(context)!.addNew),
      ),
    ),
  ],
);
