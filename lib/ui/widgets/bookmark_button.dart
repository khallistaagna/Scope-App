
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/bookmark_provider.dart';
import '../../data/models/article.dart';

class BookmarkButton extends ConsumerWidget {
  const BookmarkButton({
    super.key,
    required this.article,
    this.tonal = false,
  });

  final Article article;
  final bool tonal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(
      isBookmarkedProvider(article.url),
    );

    void onPressed() {
      ref.read(bookmarksProvider.notifier).toggleBookmark(article);
    }

    final tooltip = isSaved ? 'Hapus dari Tersimpan' : 'Simpan';

    if (tonal) {
      return IconButton.filledTonal(
        tooltip: tooltip,
        isSelected: isSaved,
        icon: const Icon(Icons.bookmark_border_rounded),
        selectedIcon: const Icon(Icons.bookmark_rounded),
        onPressed: onPressed,
      );
    }

    return IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.standard,
      constraints: const BoxConstraints.tightFor(
        width: 36,
        height: 36,
      ),
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      isSelected: isSaved,
      icon: const Icon(Icons.bookmark_border_rounded),
      selectedIcon: const Icon(Icons.bookmark_rounded),
      onPressed: onPressed,
    );
  }
}
