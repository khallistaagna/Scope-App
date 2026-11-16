import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/search_provider.dart';

// Warna disamakan dengan Beranda (merah bookmark + biru chip Featured).
// merah
const _kRed = Color(0xFFFF1D43);
const _kRedDark = Color(0xFFFF1D43);

// biru
const _kBlue = Color(0xFF0C3152);
const _kBlueDark = Color(0xFF0C3152);

class SearchSuggestions extends ConsumerWidget {
  const SearchSuggestions({super.key});

  // Topik tambahan yang tampil sebagai chip di bawah kartu.
  static const _otherTopics = [
    'Economy',
    'Football',
    'Space',
    'Startup',
    'Health',
    'Election',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    void search(String query) =>
        ref.read(searchQueryProvider.notifier).submit(query);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        // Judul section
        Row(
          children: [
            Text(
              'Popular topic',
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.local_fire_department_rounded,
                color: _kRed, size: 24),
          ],
        ),
        const SizedBox(height: 16),

        // Grid: kiri 1 kartu tinggi, kanan 2 kartu pendek
        SizedBox(
          height: 240,
          child: Row(
            children: [
              Expanded(
                child: _TopicCard(
                  title: 'Politik Global',
                  subtitle: 'Berita terbaru',
                  badge: 'TRENDING',
                  icon: Icons.public_rounded,
                  colors: const [_kBlue, _kBlueDark],
                  big: true,
                  onTap: () => search('Politics'),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _TopicCard(
                        title: 'Teknologi',
                        subtitle: 'Hari ini',
                        icon: Icons.memory_rounded,
                        colors: const [_kRed, _kRedDark],
                        onTap: () => search('Technology'),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: _TopicCard(
                        title: 'Gaya Hidup',
                        subtitle: 'Trending',
                        icon: Icons.checkroom_rounded,
                        colors: const [_kBlue, _kBlueDark],
                        onTap: () => search('Lifestyle'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Kartu lebar
        _FeaturedTopicCard(
          badge: 'SERI BARU',
          title: 'Krisis Iklim',
          description: 'Cara kita melawan pemanasan global.',
          onTap: () => search('Climate'),
        ),

        const SizedBox(height: 28),

        // Topik lainnya (chip lama tetap ada)
        Text(
          'Topik Lainnya',
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final topic in _otherTopics)
              ActionChip(
                avatar: const Icon(Icons.trending_up_rounded, size: 18),
                label: Text(topic),
                onPressed: () => search(topic),
              ),
          ],
        ),
      ],
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
    required this.onTap,
    this.badge,
    this.big = false,
  });

  final String title;
  final String subtitle;
  final String? badge;
  final IconData icon;
  final List<Color> colors;
  final bool big;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.last.withValues(alpha: 0.28),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Colors.white.withValues(alpha: 0.7),
                ),

                const Spacer(),

                if (badge != null) ...[
                  _Pill(text: badge!),
                  const SizedBox(height: 8),
                ],

                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: big ? 24 : 17,
                    height: 1.1,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _FeaturedTopicCard extends StatelessWidget {
  const _FeaturedTopicCard({
    required this.badge,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final String badge;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kRed, _kRedDark],
        ),
        boxShadow: [
          BoxShadow(
            color: _kRedDark.withValues(alpha: 0.28),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Pill(text: badge),
                  const SizedBox(height: 12),

                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 26,
                    ),
                  ),

                  const SizedBox(height: 6),

                  SizedBox(
                    width: 200,
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  FilledButton(
                    onPressed: onTap,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _kRed,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    child: const Text('Jelajahi Topik'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _Pill extends StatelessWidget {
  const _Pill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}