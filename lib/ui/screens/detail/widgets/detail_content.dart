
import 'package:flutter/material.dart';

import '../../../../data/models/article.dart';
import '../../../../core/utils/url_helper.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final description = article.description ?? '';
    final content = article.cleanContent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (description.isNotEmpty) ...[
          Text(
            description,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.65,
              color: const Color(0xFF30343A),
            ),
          ),
          const SizedBox(height: 20),
        ],

        if (content.isNotEmpty && content != description)
          Text(
            content,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.8,
              fontSize: 16,
              color: const Color(0xFF454950),
            ),
          ),

        const SizedBox(height: 28),

        Divider(
          color: Colors.grey.withValues(alpha: 0.25),
        ),

        const SizedBox(height: 12),

        Text(
          'Baca selengkapnya',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Baca artikel lengkap dari ${article.sourceName}.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 12),

        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => UrlHelper.open(
              context,
              article.url,
            ),
            icon: const Icon(Icons.open_in_new_rounded),
            label: const Text('Buka artikel lengkap'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFFF1D43),
            ),
          ),
        ),
      ],
    );
  }
}
