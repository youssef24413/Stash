import 'package:drift/drift.dart';

import '../../core/domain/enums.dart';
import '../database/app_database.dart';

class CategoryWithCount {
  const CategoryWithCount(this.category, this.itemCount);
  final Category category;
  final int itemCount;
}

class CategoryRepository {
  CategoryRepository(this._db);
  final AppDatabase _db;

  /// Categories with their item counts (links or documents depending on kind).
  Stream<List<CategoryWithCount>> watchWithCounts() {
    return _db
        .customSelect(
          '''
      SELECT c.*,
        CASE c.kind
          WHEN 'documents' THEN
            (SELECT COUNT(*) FROM documents d WHERE d.category_id = c.id)
          ELSE
            (SELECT COUNT(*) FROM links l
              WHERE l.category_id = c.id AND l.is_archived = 0)
        END AS item_count
      FROM categories c
      ORDER BY c.sort_order, c.id
      ''',
          readsFrom: {_db.categories, _db.links, _db.documents},
        )
        .watch()
        .map(
          (rows) => rows
              .map(
                (r) => CategoryWithCount(
                  _db.categories.map(r.data),
                  r.read<int>('item_count'),
                ),
              )
              .toList(growable: false),
        );
  }

  Stream<List<Category>> watchByKind(CategoryKind kind) {
    return (_db.select(_db.categories)
          ..where((c) => c.kind.equalsValue(kind))
          ..orderBy([
            (c) => OrderingTerm.asc(c.sortOrder),
            (c) => OrderingTerm.asc(c.id),
          ]))
        .watch();
  }

  Future<Category?> firstOfKind(CategoryKind kind) {
    return (_db.select(_db.categories)
          ..where((c) => c.kind.equalsValue(kind))
          ..orderBy([
            (c) => OrderingTerm.asc(c.sortOrder),
            (c) => OrderingTerm.asc(c.id),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> add({
    required String name,
    required String iconKey,
    required int colorValue,
    required CategoryKind kind,
  }) {
    return _db
        .into(_db.categories)
        .insert(
          CategoriesCompanion.insert(
            name: name.trim(),
            iconKey: Value(iconKey),
            colorValue: colorValue,
            kind: kind,
          ),
        );
  }

  Future<void> update(
    int id, {
    String? name,
    String? iconKey,
    int? colorValue,
  }) {
    return (_db.update(_db.categories)..where((c) => c.id.equals(id))).write(
      CategoriesCompanion(
        name: name == null ? const Value.absent() : Value(name.trim()),
        iconKey: iconKey == null ? const Value.absent() : Value(iconKey),
        colorValue: colorValue == null
            ? const Value.absent()
            : Value(colorValue),
      ),
    );
  }

  /// Items in the category are kept and become uncategorized (FK set null).
  Future<void> delete(int id) =>
      (_db.delete(_db.categories)..where((c) => c.id.equals(id))).go();
}
