import 'package:drift/drift.dart';

import '../../core/domain/enums.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  TextColumn get iconKey => text().withDefault(const Constant('folder'))();
  IntColumn get colorValue => integer()();
  TextColumn get kind => textEnum<CategoryKind>()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(name: 'idx_links_category', columns: {#categoryId})
@TableIndex(name: 'idx_links_created', columns: {#createdAt})
class Links extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get url => text().unique()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get siteName => text().nullable()();
  TextColumn get platform => textEnum<LinkPlatform>()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get thumbPath => text().nullable()();
  TextColumn get previewStatus => textEnum<PreviewStatus>()();
  IntColumn get categoryId => integer().nullable().references(
    Categories,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get note => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  BoolColumn get isViewed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(name: 'idx_documents_category', columns: {#categoryId})
class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 120)();
  TextColumn get filePath => text()();
  TextColumn get thumbPath => text().nullable()();
  TextColumn get fileType => textEnum<DocumentType>()();
  IntColumn get categoryId => integer().nullable().references(
    Categories,
    #id,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get isEncrypted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 40).unique()();
}

class LinkTags extends Table {
  IntColumn get linkId =>
      integer().references(Links, #id, onDelete: KeyAction.cascade)();
  IntColumn get tagId =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {linkId, tagId};
}
