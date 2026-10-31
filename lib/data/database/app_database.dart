import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../core/domain/enums.dart';
import '../../core/theme/app_tokens.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Categories, Links, Documents, Tags, LinkTags])
class AppDatabase extends _$AppDatabase {
  /// Pass an in-memory executor in tests: `AppDatabase(NativeDatabase.memory())`.
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'stash'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedCategories();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  // Seeded once, in Arabic (the default locale). Users can rename them later.
  Future<void> _seedCategories() async {
    await batch((b) {
      b.insertAll(categories, [
        CategoriesCompanion.insert(
          name: 'فيديوهات',
          iconKey: const Value('video'),
          colorValue: AppColors.pink.toARGB32(),
          kind: CategoryKind.links,
          sortOrder: const Value(0),
        ),
        CategoriesCompanion.insert(
          name: 'مستندات',
          iconKey: const Value('document'),
          colorValue: AppColors.lime.toARGB32(),
          kind: CategoryKind.documents,
          sortOrder: const Value(1),
        ),
        CategoriesCompanion.insert(
          name: 'شغل',
          iconKey: const Value('briefcase'),
          colorValue: AppColors.sky.toARGB32(),
          kind: CategoryKind.links,
          sortOrder: const Value(2),
        ),
      ]);
    });
  }
}
