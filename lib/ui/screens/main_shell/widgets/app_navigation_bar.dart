
import 'package:flutter/material.dart';

// Bottom Navigation Bar
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFFF1D43);
    const navy = Color(0xFF0C3152);

    // TODO: Ambil jumlah bookmark dari provider
    final bookmarkCount = 0;

    return Container(
      decoration: const BoxDecoration(
        color: red,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        child: NavigationBar(
          height: 85,
          backgroundColor: red,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          indicatorColor: navy,
          labelBehavior:
              NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            const NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              selectedIcon: Icon(
                Icons.home_rounded,
                color: Colors.white,
              ),
              label: 'Beranda',
            ),
            const NavigationDestination(
              icon: Icon(
                Icons.explore_outlined,
                color: Colors.white,
              ),
              selectedIcon: Icon(
                Icons.explore_rounded,
                color: Colors.white,
              ),
              label: 'Jelajahi',
            ),
            NavigationDestination(
              icon: Badge.count(
                count: bookmarkCount,
                isLabelVisible: bookmarkCount > 0,
                child: const Icon(
                  Icons.bookmarks_outlined,
                  color: Colors.white,
                ),
              ),
              selectedIcon: const Icon(
                Icons.bookmarks_rounded,
                color: Colors.white,
              ),
              label: 'Tersimpan',
            ),
          ],
        ),
      ),
    );
  }
}
