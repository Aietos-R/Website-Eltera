import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'components.dart';

class Footer extends StatelessWidget {
  final VoidCallback onKursus;
  final VoidCallback onGaleri;
  final VoidCallback onTestimoni;

  const Footer({super.key, required this.onKursus, required this.onGaleri, required this.onTestimoni});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isNarrow ? AppSpacing.lg : AppSpacing.xxxl, vertical: AppSpacing.xxl),
      decoration: const BoxDecoration(color: AppColors.surface, border: Border(top: BorderSide(color: AppColors.border, width: 1))),
      child: Column(
        children: [
          isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FooterBrand(), const SizedBox(height: AppSpacing.xl),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _FooterNav(onKursus: onKursus, onGaleri: onGaleri, onTestimoni: onTestimoni)),
                        Expanded(child: _FooterProgram()),
                        Expanded(child: _FooterKontak()),
                      ],
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _FooterBrand()),
                    Expanded(child: _FooterNav(onKursus: onKursus, onGaleri: onGaleri, onTestimoni: onTestimoni)),
                    Expanded(child: _FooterProgram()),
                    Expanded(flex: 2, child: _FooterKontak()),
                  ],
                ),
          const SizedBox(height: AppSpacing.xl),
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('© 2026 Eltera Piano. Semua hak dilindungi.', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted)),
              if (!isNarrow)
                Row(
                  children: [
                    Text('Kebijakan Privasi', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted)),
                    const SizedBox(width: AppSpacing.lg),
                    Text('Syarat & Ketentuan', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(gradient: AppGradients.heroGradient, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.music_note_rounded, color: Colors.white, size: 20)),
            const SizedBox(width: 10),
            const Text('Eltera', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        const Text('Tempat terbaik untuk memulai perjalanan musik Anda. Bergabung dengan ribuan murid yang telah sukses bersama kami.', style: AppTextStyles.bodySmall),
        const SizedBox(height: AppSpacing.lg),
        Row(children: const [_SocialIcon(icon: Icons.facebook_rounded), SizedBox(width: AppSpacing.sm), _SocialIcon(icon: Icons.camera_alt_rounded), SizedBox(width: AppSpacing.sm), _SocialIcon(icon: Icons.music_video_rounded), SizedBox(width: AppSpacing.sm), _SocialIcon(icon: Icons.message_rounded)]),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon; const _SocialIcon({required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border, width: 1)), child: Icon(icon, color: AppColors.textSecondary, size: 18));
  }
}

class _FooterNav extends StatelessWidget {
  final VoidCallback onKursus, onGaleri, onTestimoni;
  const _FooterNav({required this.onKursus, required this.onGaleri, required this.onTestimoni});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Navigasi', style: AppTextStyles.heading3.copyWith(fontSize: 16)), const SizedBox(height: AppSpacing.md),
        FooterLink(text: 'Beranda', onTap: () {}), FooterLink(text: 'Program Kursus', onTap: onKursus), FooterLink(text: 'Galeri', onTap: onGaleri), FooterLink(text: 'Testimoni', onTap: onTestimoni),
      ],
    );
  }
}

class _FooterProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Program', style: AppTextStyles.heading3.copyWith(fontSize: 16)), const SizedBox(height: AppSpacing.md),
        const FooterLink(text: 'Beginner'), const FooterLink(text: 'Intermediate'), const FooterLink(text: 'Advanced'), const FooterLink(text: 'Private Classes'),
      ],
    );
  }
}

class _FooterKontak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kontak', style: AppTextStyles.heading3.copyWith(fontSize: 16)), const SizedBox(height: AppSpacing.md),
        const _FooterContactItem(icon: Icons.location_on_rounded, text: 'Jl. Harmoni No. 123, Jakarta Pusat'), const SizedBox(height: AppSpacing.sm),
        const _FooterContactItem(icon: Icons.phone_rounded, text: '+62 812-3456-7890'), const SizedBox(height: AppSpacing.sm),
        const _FooterContactItem(icon: Icons.email_rounded, text: 'info@elterapiano.com'),
      ],
    );
  }
}

class _FooterContactItem extends StatelessWidget {
  final IconData icon; final String text;
  const _FooterContactItem({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Padding(padding: const EdgeInsets.only(top: 2), child: Icon(icon, size: 16, color: AppColors.textMuted)), const SizedBox(width: 8), Expanded(child: Text(text, style: AppTextStyles.bodySmall))]);
  }
}