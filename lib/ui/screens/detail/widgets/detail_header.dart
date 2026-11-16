
import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';
import '../../../widgets/source_label.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final author = article.author;
    final byline = author == null || author.trim().isEmpty
        ? article.sourceName
        : author;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SourceLabel(name: article.sourceName),

        const SizedBox(height: 14),

        Text(
          article.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.12,
            letterSpacing: -0.8,
            color: const Color(0xFF17191D),
          ),
        ),

        const SizedBox(height: 22),

        Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: const Color(0xFF0C3152)
                  .withValues(alpha: 0.12),
              child: Text(
                byline.isNotEmpty
                    ? byline.characters.first.toUpperCase()
                    : 'N',
                style: const TextStyle(
                  color: Color(0xFF0C3152),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    byline,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    DateFormatter.full(article.publishedAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
