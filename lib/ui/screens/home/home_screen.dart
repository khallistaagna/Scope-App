
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';
import 'widgets/category_chips.dart';
import 'widgets/headlines_section.dart';
import 'widgets/home_app_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    final provider = headlinesProvider(
      ref.read(SelectedCategoryProvider),
    );

    ref.invalidate(provider);

    try {
      await ref.read(provider.future);
    } catch (_) {
      // Error ditampilkan oleh HeadlinesSection.
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: CustomScrollView(
        slivers: [
          const HomeAppBar(),
          // Bungkus CategoryChips dengan SliverToBoxAdapter
          const SliverToBoxAdapter(
            child: CategoryChips(),
          ),
          const HeadlinesSection(),
        ],
      ),
    );
  }
}