import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

const _icons = <String, IconData>{
  'video': PhosphorIconsBold.playCircle,
  'document': PhosphorIconsBold.identificationCard,
  'briefcase': PhosphorIconsBold.briefcase,
  'folder': PhosphorIconsBold.folder,
  'star': PhosphorIconsBold.star,
  'book': PhosphorIconsBold.bookOpen,
  'shopping': PhosphorIconsBold.shoppingBag,
  'heart': PhosphorIconsBold.heart,
  'idea': PhosphorIconsBold.lightbulb,
};

/// Keys a user can pick from when creating a category.
List<String> get categoryIconKeys => _icons.keys.toList(growable: false);

IconData categoryIcon(String key) => _icons[key] ?? PhosphorIconsBold.folder;
