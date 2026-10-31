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
  String linksCount(int count) {
    return '$count links';
  }

  @override
  String filesCount(int count) {
    return '$count files';
  }

  @override
  String get emptyLinksTitle => 'No links yet';

  @override
  String get emptyLinksBody =>
      'Share any link from TikTok, Instagram, or YouTube and it will show up here.';

  @override
  String get errorGeneric => 'Something went wrong. Try again.';

  @override
  String get navHome => 'Home';

  @override
  String get navCategories => 'Categories';

  @override
  String get navSettings => 'Settings';

  @override
  String get addNew => 'Add';
}
