final _urlPattern = RegExp(r'https?://[^\s]+', caseSensitive: false);
final _schemePattern = RegExp(r'^https?://', caseSensitive: false);

/// Pulls the first URL out of shared text (share intents often add a caption).
String? extractFirstUrl(String text) => _urlPattern.firstMatch(text)?.group(0);

String normalizeUrl(String raw) {
  final value = raw.trim();
  return _schemePattern.hasMatch(value) ? value : 'https://$value';
}
