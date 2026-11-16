
import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/article.dart';
import 'article_image.dart';
import 'bookmark_button.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    super.key,
    required this.article,
    this.category,
    this.readTime,
  });

  final Article article;
  final String? category;
  final String? readTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final mutedStyle = theme.textTheme.labelSmall?.copyWith(
      color: cs.onSurfaceVariant,
      fontWeight: FontWeight.w500,
    );

    return Material(
      color: cs.surfaceContainerHighest.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () => AppRouter.openArticle(context, article),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 96,
                height: 96,
                child: ArticleImage(
                  url: article.imageUrl,
                  radius: 22,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: SizedBox(
                  height: 96,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SOURCE + BOOKMARK
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              category ?? article.sourceName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: mutedStyle,
                            ),
                          ),

                          if (readTime != null) ...[
                            const SizedBox(width: 6),
                            Text(
                              readTime!,
                              style: mutedStyle,
                            ),
                          ],

                          const SizedBox(width: 4),

                          SizedBox(
                            width: 36,
                            height: 36,
                            child: BookmarkButton(
                              article: article,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // ARTICLE TITLE
                      Expanded(
                        child: Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.25,
                          ),
                        ),
                      ),

                      // PUBLISHED TIME
                      Text(
                        DateFormatter.relative(article.publishedAt),
                        style: mutedStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
