import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/domain/enums.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/category_visuals.dart';
import '../../../core/theme/platform_visuals.dart';
import '../../../core/widgets/brutal_box.dart';
import '../../../data/database/app_database.dart';
import '../../../data/providers.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../l10n/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // TODO: replace with the real user name from settings.
  static const _userName = 'يوسف';

  /// Debug only: long-press the avatar to insert a sample link.
  /// TODO: remove once the add-link flow exists.
  Future<void> _addSample(WidgetRef ref) async {
    final links = ref.read(linkRepositoryProvider);
    final category = await ref
        .read(categoryRepositoryProvider)
        .firstOfKind(CategoryKind.links);
    final stamp = DateTime.now().millisecondsSinceEpoch;
    final result = await links.add(
      url: 'https://www.youtube.com/watch?v=$stamp',
      categoryId: category?.id,
    );
    await links.savePreview(
      result.id,
      title: 'فيديو تجريبي',
      siteName: 'youtube.com',
      status: PreviewStatus.ready,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final categories = ref.watch(categoriesWithCountProvider);
    final recent = ref.watch(recentLinksProvider);

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
                    GestureDetector(
                      onLongPress: kDebugMode ? () => _addSample(ref) : null,
                      child: BrutalBox(
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
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.lg),
                BrutalBox(
                  padding: const EdgeInsets.all(AppSpace.md),
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
          categories.when(
            data: (items) => SliverPadding(
              padding: hPad,
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 240,
                  mainAxisSpacing: AppSpace.md,
                  crossAxisSpacing: AppSpace.md,
                  childAspectRatio: 1.35,
                ),
                itemCount: items.length,
                itemBuilder: (_, i) => _CategoryCard(item: items[i]),
              ),
            ),
            loading: () => const SliverToBoxAdapter(),
            error: (_, __) => SliverToBoxAdapter(
              child: Padding(padding: hPad, child: Text(l.errorGeneric)),
            ),
          ),
          SliverPadding(
            padding: hPad.copyWith(top: AppSpace.xl, bottom: AppSpace.md),
            sliver: SliverToBoxAdapter(
              child: Text(
                l.recentSaved,
                style: text.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
          SliverPadding(
            padding: hPad.copyWith(bottom: AppSpace.xl),
            sliver: recent.when(
              data: (links) => links.isEmpty
                  ? const SliverToBoxAdapter(child: _EmptyLinks())
                  : SliverList.separated(
                      itemCount: links.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpace.md),
                      itemBuilder: (_, i) => _LinkCard(link: links[i]),
                    ),
              loading: () => const SliverToBoxAdapter(),
              error: (_, __) => SliverToBoxAdapter(child: Text(l.errorGeneric)),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.item});
  final CategoryWithCount item;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final category = item.category;
    final count = category.kind == CategoryKind.documents
        ? l.filesCount(item.itemCount)
        : l.linksCount(item.itemCount);

    return BrutalBox(
      // TODO: open category details.
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BrutalBox(
            color: Color(category.colorValue),
            padding: const EdgeInsets.all(AppSpace.sm),
            radius: AppRadius.sm,
            child: Icon(categoryIcon(category.iconKey), size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                count,
                style: text.bodySmall?.copyWith(color: AppColors.subtle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyLinks extends StatelessWidget {
  const _EmptyLinks();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    return BrutalBox(
      color: AppColors.lime,
      padding: const EdgeInsets.all(AppSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.xs,
        children: [
          Text(
            l.emptyLinksTitle,
            style: text.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          Text(l.emptyLinksBody, style: text.bodyMedium),
        ],
      ),
    );
  }
}

class _LinkCard extends StatelessWidget {
  const _LinkCard({required this.link});
  final Link link;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final host = (Uri.tryParse(link.url)?.host ?? link.url).replaceFirst(
      'www.',
      '',
    );

    return BrutalBox(
      padding: EdgeInsets.zero,
      // TODO: open link / detail sheet.
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Thumb(link: link),
          Padding(
            padding: const EdgeInsets.all(AppSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  link.title ?? host,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  link.siteName ?? host,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

class _Thumb extends StatelessWidget {
  const _Thumb({required this.link});
  final Link link;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final path = link.thumbPath;
    final fallback = Center(child: Icon(platformIcon(link.platform), size: 44));

    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: platformColor(link.platform),
        border: const Border(
          bottom: BorderSide(color: AppColors.ink, width: AppBrutal.border),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: path == null
                ? fallback
                : Image.file(
                    File(path),
                    fit: BoxFit.cover,
                    cacheWidth: 800,
                    errorBuilder: (_, __, ___) => fallback,
                  ),
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
                link.platform.label,
                style: text.labelSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
