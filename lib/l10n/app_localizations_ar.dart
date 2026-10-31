// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'STASH';

  @override
  String greeting(String name) {
    return 'أهلاً $name';
  }

  @override
  String get searchHint => 'ابحث في كل حاجة';

  @override
  String get recentSaved => 'آخر المحفوظات';

  @override
  String linksCount(int count) {
    return '$count لينك';
  }

  @override
  String filesCount(int count) {
    return '$count ملفات';
  }

  @override
  String get emptyLinksTitle => 'لسه مفيش لينكات';

  @override
  String get emptyLinksBody =>
      'شارك أي لينك من تيك توك أو إنستجرام أو يوتيوب وهيظهر هنا.';

  @override
  String get errorGeneric => 'حصلت مشكلة. جرّب تاني.';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navCategories => 'الكاتيجوريز';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get addNew => 'إضافة';
}
