import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'components.dart';

class NavBar extends StatelessWidget {
  final Map<String, dynamic>? userData;
  final VoidCallback onKursus;
  final VoidCallback onGaleri;
  final VoidCallback onTestimoni;
  final ScrollController scrollController;

  const NavBar({
    super.key,
    this.userData,
    required this.onKursus,
    required this.onGaleri,
    required this.onTestimoni,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 768;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill), // Bentuk Oval Melengkung
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A3A).withValues(alpha: 0.3), // Warna kaca gelap
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: AppColors.white20, width: 1), // Garis tepi kaca
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/logo_eltera.png', height: 36,
                    errorBuilder: (context, error, stackTrace) => Container(width: 36, height: 36, decoration: BoxDecoration(gradient: AppGradients.heroGradient, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.music_note_rounded, color: Colors.white, size: 20)),
                  ),
                  const SizedBox(width: 10),
                  const Text('Eltera', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary, letterSpacing: -0.5)),
                ],
              ),
              if (!isMobile)
                Row(
                  children: [
                    _NavLink(text: 'Beranda', onTap: () => scrollController.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut)),
                    _NavLink(text: 'Kursus', onTap: onKursus),
                    _NavLink(text: 'Galeri', onTap: onGaleri),
                    _NavLink(text: 'Testimoni', onTap: onTestimoni),
                    const SizedBox(width: AppSpacing.md),
                    if (userData == null)
                      GradientButton(text: 'Daftar', height: 40, width: 100, onPressed: () => Navigator.pushNamed(context, '/login'))
                    else
                      _buildProfileDropdown(context),
                  ],
                )
              else
                _buildMobileMenu(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDropdown(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 50), color: AppColors.surfaceLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.border)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(AppRadius.pill)),
        child: Row(
          children: [
            const CircleAvatar(radius: 16, backgroundColor: AppColors.primary, child: Icon(Icons.person, color: Colors.white, size: 18)),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData!['nama_user'] ?? 'Pianis', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, height: 1)),
                Text(userData!['role'] == 'admin' ? 'Administrator' : 'Murid', style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
            const SizedBox(width: 5), const Icon(Icons.arrow_drop_down, color: AppColors.textMuted),
          ],
        ),
      ),
      itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
        PopupMenuItem(enabled: false, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(userData!['nama_user'] ?? 'Pianis', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)), Text(userData!['role'] == 'admin' ? 'Administrator' : 'Murid', style: const TextStyle(color: AppColors.textMuted, fontSize: 12))])),
        const PopupMenuDivider(),
        if (userData!['role'] == 'admin') _menuItem(Icons.dashboard, 'Dashboard Admin', onTap: () {}),
        _menuItem(Icons.person, 'Profil Saya', onTap: () {}),
        _menuItem(Icons.history, 'Jadwal Les', onTap: () {}),
        const PopupMenuDivider(),
        PopupMenuItem(onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false), child: const Row(children: [Icon(Icons.logout, color: Colors.redAccent), SizedBox(width: 10), Text('Keluar', style: TextStyle(color: Colors.redAccent))])),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 50), icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary, size: 28), color: AppColors.surfaceLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.border)),
      itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
        _menuItem(Icons.home, 'Beranda', onTap: () { Navigator.pop(context); scrollController.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut); }),
        _menuItem(Icons.library_music, 'Kursus', onTap: () { Navigator.pop(context); onKursus(); }),
        _menuItem(Icons.photo_library, 'Galeri', onTap: () { Navigator.pop(context); onGaleri(); }),
        _menuItem(Icons.star, 'Testimoni', onTap: () { Navigator.pop(context); onTestimoni(); }),
        const PopupMenuDivider(),
        if (userData == null)
          _menuItem(Icons.login, 'Login', onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/login'); })
        else ...[
          PopupMenuItem(enabled: false, child: Text('Halo, ${userData!['nama_user'] ?? 'Pianis'}!', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
          if (userData!['role'] == 'admin') _menuItem(Icons.dashboard, 'Dashboard Admin', onTap: () {}),
          _menuItem(Icons.person, 'Profil Saya', onTap: () {}),
          const PopupMenuDivider(),
          PopupMenuItem(onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false), child: const Row(children: [Icon(Icons.logout, color: Colors.redAccent), SizedBox(width: 10), Text('Keluar', style: TextStyle(color: Colors.redAccent))])),
        ]
      ],
    );
  }

  PopupMenuItem _menuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return PopupMenuItem(onTap: onTap, child: Row(children: [Icon(icon, color: AppColors.textPrimary), const SizedBox(width: 10), Text(title, style: const TextStyle(color: AppColors.textPrimary))]));
  }
}

class _NavLink extends StatelessWidget {
  final String text; final VoidCallback onTap;
  const _NavLink({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text(text, style: AppTextStyles.navLink)));
  }
}