import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/brutal_box.dart';
import '../../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // TODO: replace with real user name and data from the repository.
  static const _userName = 'يوسف';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;

    final categories = <_CategoryUi>[
      _CategoryUi(
        l.catVideos,
        PhosphorIconsBold.playCircle,
        AppColors.pink,
        l.linksCount(24),
      ),
      _CategoryUi(
        l.catDocuments,
        PhosphorIconsBold.identificationCard,
        AppColors.lime,
        l.filesCount(8),
      ),
      _CategoryUi(
        l.catRecipes,
        PhosphorIconsBold.chefHat,
        AppColors.yellow,
        l.linksCount(11),
      ),
      _CategoryUi(
        l.catWork,
        PhosphorIconsBold.briefcase,
        AppColors.sky,
        l.linksCount(9),
      ),
    ];

    const hPad = EdgeInsets.symmetric(horizontal: AppSpace.lg);

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: hPad.copyWith(top: AppSpace.lg),
            sliver: SliverList.list(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.greeting(_userName),
                            style: text.bodyMedium?.copyWith(
                              color: AppColors.subtle,
                            ),
                          ),
                          Text(
                            l.appName,
                            style: text.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BrutalBox(
                      color: AppColors.lime,
                      padding: EdgeInsets.zero,
                      radius: AppRadius.sm,
                      child: SizedBox(
                        width: 42,
                        height: 42,
                        child: Center(
                          child: Text(
                            _userName.characters.first,
                            style: text.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.lg),
                BrutalBox(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.md,
                    vertical: AppSpace.md,
                  ),
                  // TODO: navigate to search once the feature exists.
                  onTap: () {},
                  child: Row(
                    spacing: AppSpace.sm,
                    children: [
                      const Icon(PhosphorIconsBold.magnifyingGlass, size: 20),
                      Text(
                        l.searchHint,
                        style: text.bodyMedium?.copyWith(
                          color: AppColors.subtle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpace.lg),
              ],
            ),
          ),
          SliverPadding(
            padding: hPad,
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 240,
                mainAxisSpacing: AppSpace.md,
                crossAxisSpacing: AppSpace.md,
                childAspectRatio: 1.35,
              ),
              itemCount: categories.length,
              itemBuilder: (_, i) => _CategoryCard(data: categories[i]),
            ),
          ),
          SliverPadding(
            padding: hPad.copyWith(top: AppSpace.xl, bottom: AppSpace.xl),
            sliver: SliverList.list(
              children: [
                Text(
                  l.recentSaved,
                  style: text.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpace.md),
                const _LinkCard(
                  title: 'أحسن طريقة لتعلم Flutter',
                  meta: 'youtube.com',
                  platform: 'YouTube',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryUi {
  const _CategoryUi(this.name, this.icon, this.color, this.count);
  final String name;
  final IconData icon;
  final Color color;
  final String count;
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.data});
  final _CategoryUi data;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return BrutalBox(
      // TODO: open category details.
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BrutalBox(
            color: data.color,
            padding: const EdgeInsets.all(AppSpace.sm),
            radius: AppRadius.sm,
            child: Icon(data.icon, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: text.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                data.count,
                style: text.bodySmall?.copyWith(color: AppColors.subtle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LinkCard extends StatelessWidget {
  const _LinkCard({
    required this.title,
    required this.meta,
    required this.platform,
  });
  final String title;
  final String meta;
  final String platform;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return BrutalBox(
      padding: EdgeInsets.zero,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Placeholder thumbnail. Will become a cached network/local image.
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: AppColors.pink,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.ink,
                  width: AppBrutal.border,
                ),
              ),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(PhosphorIconsBold.playCircle, size: 44),
                ),
                PositionedDirectional(
                  top: AppSpace.sm,
                  end: AppSpace.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lime,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(
                        color: AppColors.ink,
                        width: AppBrutal.border,
                      ),
                    ),
                    child: Text(
                      platform,
                      style: text.labelSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  meta,
                  style: text.bodySmall?.copyWith(color: AppColors.subtle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
