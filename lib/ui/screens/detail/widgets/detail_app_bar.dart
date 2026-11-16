
import 'package:flutter/material.dart';

import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 340,
      toolbarHeight: 64,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,

      leading: Padding(
        padding: const EdgeInsets.all(6),
        child: IconButton.filledTonal(
          tooltip: 'Kembali',
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.9),
            foregroundColor: const Color(0xFF0C3152),
          ),
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: BookmarkButton(
            article: article,
            tonal: true,
          ),
        ),
      ],

      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            ArticleImage(
              url: article.imageUrl,
              radius: 0,
            ),

            // Gradient shadow di bagian bawah gambar
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color(0x33FFFFFF),
                    Color(0xCCFFFFFF),
                    Colors.white,
                  ],
                  stops: [0.45, 0.60, 0.75, 0.90, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
