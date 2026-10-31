import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../domain/enums.dart';
import 'app_tokens.dart';

Color platformColor(LinkPlatform p) => switch (p) {
  LinkPlatform.youtube => AppColors.pink,
  LinkPlatform.tiktok => AppColors.sky,
  LinkPlatform.instagram => AppColors.yellow,
  LinkPlatform.facebook => AppColors.sky,
  LinkPlatform.x => AppColors.lime,
  LinkPlatform.other => AppColors.lime,
};

IconData platformIcon(LinkPlatform p) => switch (p) {
  LinkPlatform.youtube => PhosphorIconsBold.youtubeLogo,
  LinkPlatform.tiktok => PhosphorIconsBold.tiktokLogo,
  LinkPlatform.instagram => PhosphorIconsBold.instagramLogo,
  LinkPlatform.facebook => PhosphorIconsBold.facebookLogo,
  LinkPlatform.x => PhosphorIconsBold.xLogo,
  LinkPlatform.other => PhosphorIconsBold.link,
};
