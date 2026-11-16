import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientButton extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final double? width; final double height;
  const GradientButton({super.key, required this.text, this.onPressed, this.width, this.height = 52});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width, height: height,
        decoration: BoxDecoration(
          gradient: AppGradients.primaryGradient, borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 8))],
        ),
        child: Center(child: Text(text, style: AppTextStyles.button)),
      ),
    );
  }
}

class OutlinedGlassButton extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final double? width; final double height;
  const OutlinedGlassButton({super.key, required this.text, this.onPressed, this.width, this.height = 52});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width, height: height,
        decoration: BoxDecoration(color: AppColors.white10, borderRadius: BorderRadius.circular(AppRadius.pill), border: Border.all(color: AppColors.white30, width: 1)),
        child: Center(child: Text(text, style: AppTextStyles.button)),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title; final String subtitle;
  const SectionTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppTextStyles.heading2, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        Text(subtitle, style: AppTextStyles.body, textAlign: TextAlign.center),
      ],
    );
  }
}

class PianoKeysWidget extends StatelessWidget {
  final double width; final double height; final double opacity;
  const PianoKeysWidget({super.key, this.width = 400, this.height = 200, this.opacity = 0.15});

  @override
  Widget build(BuildContext context) {
    final whiteKeyWidth = width / 7; final blackKeyWidth = whiteKeyWidth * 0.6; final blackKeyHeight = height * 0.62;
    final blackKeyPositions = [1, 2, 4, 5, 6]; 
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: width, height: height,
        child: Stack(
          children: [
            Row(children: List.generate(7, (i) => Container(
              width: whiteKeyWidth - 1, height: height, margin: const EdgeInsets.only(right: 1),
              decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 4))]),
            ))),
            ...blackKeyPositions.map((pos) {
              final leftOffset = (pos * whiteKeyWidth) - (blackKeyWidth / 2);
              return Positioned(
                left: leftOffset, top: 0,
                child: Container(
                  width: blackKeyWidth, height: blackKeyHeight,
                  decoration: BoxDecoration(gradient: AppGradients.pianoKeyGradient, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 8, offset: const Offset(0, 4))]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatefulWidget {
  final IconData icon; final String title; final String description;
  const FeatureCard({super.key, required this.icon, required this.title, required this.description});

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Animasi transisi halus
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          gradient: _isHovered 
              ? LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.15), AppColors.accentCopper.withValues(alpha: 0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight) 
              : AppGradients.cardGradient,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: _isHovered ? AppColors.primary.withValues(alpha: 0.6) : AppColors.border, width: _isHovered ? 1.5 : 1),
          boxShadow: _isHovered ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 8))] : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 72, height: 72,
              decoration: BoxDecoration(
                gradient: AppGradients.heroGradient, 
                borderRadius: BorderRadius.circular(AppRadius.lg), 
                boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: _isHovered ? 0.6 : 0.3), blurRadius: _isHovered ? 24 : 16, offset: const Offset(0, 4))]
              ),
              child: Icon(widget.icon, color: Colors.white, size: 32),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(widget.title, style: AppTextStyles.heading3, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(widget.description, style: AppTextStyles.body, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final String level; final String levelLabel; final String title; final String duration; final String price; final String description;
  const CourseCard({super.key, required this.level, required this.levelLabel, required this.title, required this.duration, required this.price, required this.description});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          gradient: _isHovered 
              ? LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.15), AppColors.accentCopper.withValues(alpha: 0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight) 
              : AppGradients.cardGradient,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: _isHovered ? AppColors.primary.withValues(alpha: 0.5) : AppColors.border, width: _isHovered ? 1.5 : 1),
          boxShadow: _isHovered ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 24, offset: const Offset(0, 8))] : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: _isHovered ? 0.3 : 0.15), borderRadius: BorderRadius.circular(AppRadius.pill), border: Border.all(color: AppColors.primary.withValues(alpha: _isHovered ? 0.8 : 0.4), width: 1)),
              child: Text(widget.levelLabel, style: AppTextStyles.label.copyWith(color: AppColors.primary)),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(widget.title, style: AppTextStyles.heading3),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                const Icon(Icons.schedule_rounded, size: 18, color: AppColors.textMuted), const SizedBox(width: 8),
                Text(widget.duration, style: AppTextStyles.bodySmall), const SizedBox(width: AppSpacing.md),
                const Icon(Icons.payments_outlined, size: 18, color: AppColors.textMuted), const SizedBox(width: 8),
                Text(widget.price, style: AppTextStyles.body.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(widget.description, style: AppTextStyles.body),
            const SizedBox(height: AppSpacing.xl),
            GradientButton(text: 'Pilih Kursus', width: double.infinity, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class GalleryNavButton extends StatefulWidget {
  final IconData icon; final VoidCallback onTap;
  const GalleryNavButton({super.key, required this.icon, required this.onTap});

  @override
  State<GalleryNavButton> createState() => _GalleryNavButtonState();
}

class _GalleryNavButtonState extends State<GalleryNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surfaceLight, 
            shape: BoxShape.circle, 
            border: Border.all(color: _isHovered ? AppColors.primary : AppColors.border, width: _isHovered ? 1.5 : 1)
          ),
          child: Icon(widget.icon, color: _isHovered ? AppColors.primary : AppColors.textPrimary),
        ),
      ),
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final String name; final String classLevel; final String review; final int rating;
  const TestimonialCard({super.key, required this.name, required this.classLevel, required this.review, this.rating = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(gradient: AppGradients.cardGradient, borderRadius: BorderRadius.circular(AppRadius.xl), border: Border.all(color: AppColors.border, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: 72, height: 72, decoration: const BoxDecoration(gradient: AppGradients.heroGradient, shape: BoxShape.circle), child: const Icon(Icons.person_rounded, color: Colors.white, size: 36)),
          const SizedBox(height: AppSpacing.md),
          Text(name, style: AppTextStyles.heading3), const SizedBox(height: 4),
          Text(classLevel, style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
          const SizedBox(height: AppSpacing.md),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(rating, (i) => const Padding(padding: EdgeInsets.symmetric(horizontal: 2), child: Icon(Icons.star_rounded, color: Color(0xFFFFB800), size: 20)))),
          const SizedBox(height: AppSpacing.md),
          Text(review, style: AppTextStyles.body, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon; final String text;
  const ContactInfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border, width: 1)),
      child: Row(
        children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(gradient: AppGradients.primaryGradient, borderRadius: BorderRadius.circular(AppRadius.md)), child: Icon(icon, color: Colors.white, size: 20)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(text, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}

class FooterLink extends StatelessWidget {
  final String text; final VoidCallback? onTap;
  const FooterLink({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Text(text, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary))));
  }
}