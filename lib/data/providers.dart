import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/app_database.dart';
import 'repositories/category_repository.dart';
import 'repositories/document_repository.dart';
import 'repositories/link_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(ref.watch(databaseProvider)),
);

final linkRepositoryProvider = Provider<LinkRepository>(
  (ref) => LinkRepository(ref.watch(databaseProvider)),
);

final documentRepositoryProvider = Provider<DocumentRepository>(
  (ref) => DocumentRepository(ref.watch(databaseProvider)),
);

final categoriesWithCountProvider = StreamProvider<List<CategoryWithCount>>(
  (ref) => ref.watch(categoryRepositoryProvider).watchWithCounts(),
);

final recentLinksProvider = StreamProvider<List<Link>>(
  (ref) => ref.watch(linkRepositoryProvider).watchRecent(limit: 10),
);
