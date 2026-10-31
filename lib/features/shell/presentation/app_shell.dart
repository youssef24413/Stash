import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/brutal_box.dart';
import '../../../l10n/app_localizations.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  void _goBranch(int index) =>
      shell.goBranch(index, initialLocation: index == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final items = <_NavData>[
      _NavData(
        l.navHome,
        PhosphorIconsBold.house,
        () => _goBranch(0),
        shell.currentIndex == 0,
      ),
      _NavData(
        l.navCategories,
        PhosphorIconsBold.squaresFour,
        () => _goBranch(1),
        shell.currentIndex == 1,
      ),
      _NavData(
        l.addNew,
        PhosphorIconsBold.plus,
        () => context.push('/add'),
        false,
        isAdd: true,
      ),
      _NavData(
        l.navSettings,
        PhosphorIconsBold.gear,
        () => _goBranch(2),
        shell.currentIndex == 2,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= AppBreakpoints.tablet;

        if (wide) {
          return Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpace.lg),
                    child: BrutalBox(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpace.sm,
                        vertical: AppSpace.md,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: AppSpace.sm,
                        children: items
                            .map((e) => _NavButton(data: e))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                Expanded(child: shell),
              ],
            ),
          );
        }

        return Scaffold(
          body: shell,
          bottomNavigationBar: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpace.lg,
                0,
                AppSpace.lg,
                AppSpace.md,
              ),
              child: BrutalBox(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.sm,
                  vertical: AppSpace.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: items.map((e) => _NavButton(data: e)).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavData {
  const _NavData(
    this.label,
    this.icon,
    this.onTap,
    this.selected, {
    this.isAdd = false,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;
  final bool isAdd;
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.data});
  final _NavData data;

  @override
  Widget build(BuildContext context) {
    final bg = data.isAdd
        ? AppColors.ink
        : data.selected
        ? AppColors.lime
        : Colors.transparent;
    final fg = data.isAdd ? AppColors.lime : AppColors.ink;

    return Semantics(
      button: true,
      selected: data.selected,
      label: data.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: data.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 52,
          height: 44,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(
              color: data.selected || data.isAdd
                  ? AppColors.ink
                  : Colors.transparent,
              width: AppBrutal.border,
            ),
          ),
          child: Icon(data.icon, color: fg, size: 22),
        ),
      ),
    );
  }
}
