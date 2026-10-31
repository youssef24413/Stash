// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'STASH';

  @override
  String greeting(String name) {
    return 'Hey $name';
  }

  @override
  String get searchHint => 'Search everything';

  @override
  String get recentSaved => 'Recently saved';

  @override
  String get catVideos => 'Videos';

  @override
  String get catDocuments => 'Documents';

  @override
  String get catRecipes => 'Recipes';

  @override
  String get catWork => 'Work';

  @override
  String linksCount(int count) {
    return '$count links';
  }

  @override
  String filesCount(int count) {
    return '$count files';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navCategories => 'Categories';

  @override
  String get navSettings => 'Settings';

  @override
  String get addNew => 'Add';
}
