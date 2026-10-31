import 'package:drift/drift.dart';

import '../../core/domain/enums.dart';
import '../database/app_database.dart';

class DocumentRepository {
  DocumentRepository(this._db);
  final AppDatabase _db;

  Stream<List<Document>> watchByCategory(int categoryId) {
    return (_db.select(_db.documents)
          ..where((d) => d.categoryId.equals(categoryId))
          ..orderBy([
            (d) => OrderingTerm.desc(d.createdAt),
            (d) => OrderingTerm.desc(d.id),
          ]))
        .watch();
  }

  Stream<List<Document>> watchAll() {
    return (_db.select(_db.documents)..orderBy([
          (d) => OrderingTerm.desc(d.createdAt),
          (d) => OrderingTerm.desc(d.id),
        ]))
        .watch();
  }

  Future<int> add({
    required String title,
    required String filePath,
    required DocumentType type,
    int? categoryId,
    DateTime? expiryDate,
    String? note,
  }) {
    return _db
        .into(_db.documents)
        .insert(
          DocumentsCompanion.insert(
            title: title.trim(),
            filePath: filePath,
            fileType: type,
            categoryId: Value(categoryId),
            expiryDate: Value(expiryDate),
            note: Value(note),
          ),
        );
  }

  /// Deletes the row only. The file service will remove the file on disk.
  Future<void> delete(int id) =>
      (_db.delete(_db.documents)..where((d) => d.id.equals(id))).go();
}
