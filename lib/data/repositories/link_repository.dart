import 'package:drift/drift.dart';

import '../../core/domain/enums.dart';
import '../../core/utils/url_utils.dart';
import '../database/app_database.dart';

class LinkRepository {
  LinkRepository(this._db);
  final AppDatabase _db;

  Stream<List<Link>> watchRecent({int limit = 10}) {
    return (_db.select(_db.links)
          ..where((l) => l.isArchived.equals(false))
          ..orderBy([
            (l) => OrderingTerm.desc(l.createdAt),
            (l) => OrderingTerm.desc(l.id),
          ])
          ..limit(limit))
        .watch();
  }

  Stream<List<Link>> watchByCategory(int categoryId) {
    return (_db.select(_db.links)
          ..where(
            (l) => l.categoryId.equals(categoryId) & l.isArchived.equals(false),
          )
          ..orderBy([
            (l) => OrderingTerm.desc(l.createdAt),
            (l) => OrderingTerm.desc(l.id),
          ]))
        .watch();
  }

  /// Saves the link instantly (preview is fetched later in the background).
  /// If the URL already exists, returns the existing row and flags it.
  Future<({int id, bool isDuplicate})> add({
    required String url,
    int? categoryId,
    String? note,
  }) async {
    final normalized = normalizeUrl(url);

    final existing = await (_db.select(
      _db.links,
    )..where((l) => l.url.equals(normalized))).getSingleOrNull();
    if (existing != null) return (id: existing.id, isDuplicate: true);

    final id = await _db
        .into(_db.links)
        .insert(
          LinksCompanion.insert(
            url: normalized,
            platform: LinkPlatform.fromUrl(normalized),
            previewStatus: PreviewStatus.pending,
            categoryId: Value(categoryId),
            note: Value(note),
          ),
        );
    return (id: id, isDuplicate: false);
  }

  Future<void> savePreview(
    int id, {
    String? title,
    String? description,
    String? siteName,
    String? imageUrl,
    String? thumbPath,
    required PreviewStatus status,
  }) {
    return (_db.update(_db.links)..where((l) => l.id.equals(id))).write(
      LinksCompanion(
        title: Value(title),
        description: Value(description),
        siteName: Value(siteName),
        imageUrl: Value(imageUrl),
        thumbPath: Value(thumbPath),
        previewStatus: Value(status),
      ),
    );
  }

  Future<void> toggleFavorite(Link link) =>
      _write(link.id, LinksCompanion(isFavorite: Value(!link.isFavorite)));

  Future<void> markViewed(int id) =>
      _write(id, const LinksCompanion(isViewed: Value(true)));

  Future<void> setArchived(int id, bool archived) =>
      _write(id, LinksCompanion(isArchived: Value(archived)));

  Future<void> delete(int id) =>
      (_db.delete(_db.links)..where((l) => l.id.equals(id))).go();

  Future<void> _write(int id, LinksCompanion data) =>
      (_db.update(_db.links)..where((l) => l.id.equals(id))).write(data);
}
