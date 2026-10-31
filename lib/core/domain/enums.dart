enum CategoryKind { links, documents }

enum PreviewStatus { pending, ready, failed }

enum DocumentType { image, pdf }

enum LinkPlatform {
  youtube('YouTube'),
  tiktok('TikTok'),
  instagram('Instagram'),
  facebook('Facebook'),
  x('X'),
  other('Web');

  const LinkPlatform(this.label);
  final String label;

  static LinkPlatform fromUrl(String url) {
    final host = Uri.tryParse(url)?.host.toLowerCase() ?? '';
    bool match(List<String> domains) =>
        domains.any((d) => host == d || host.endsWith('.$d'));

    if (match(['youtube.com', 'youtu.be'])) return LinkPlatform.youtube;
    if (match(['tiktok.com'])) return LinkPlatform.tiktok;
    if (match(['instagram.com'])) return LinkPlatform.instagram;
    if (match(['facebook.com', 'fb.com', 'fb.watch'])) {
      return LinkPlatform.facebook;
    }
    if (match(['x.com', 'twitter.com', 't.co'])) return LinkPlatform.x;
    return LinkPlatform.other;
  }
}
