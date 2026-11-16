import 'package:flutter/material.dart';

class AppColors {
  // Warna Utama (Rose Gold / Copper dari tulisan Eltera)
  static const Color primary = Color(0xFFC78B6E);
  static const Color primaryEnd = Color(0xFFE5B59C);
  
  // Warna Background & Surface (Navy Blue dari lingkaran logo)
  static const Color background = Color(0xFF08121F); // Sangat gelap (Nyaris Hitam/Navy)
  static const Color surface = Color(0xFF0F1E33); // Navy gelap
  static const Color surfaceLight = Color(0xFF162945); // Navy agak terang
  static const Color border = Color(0xFF263C59); // Biru pudar untuk garis tepi

  // Warna Teks
  static const Color textPrimary = Color(0xFFF0F2F5); // Putih sedikit keperakan
  static const Color textSecondary = Color(0xFFA6B2C1); // Silver tone (dari huruf LR)
  static const Color textMuted = Color(0xFF657A94); // Navy pudar
  
  // Warna Aksen Tambahan
  static const Color accent = Color(0xFFB4BFCB); // Silver / Platinum
  static const Color accentCopper = Color(0xFF9E654C); // Tembaga gelap

  // Transparansi
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color white30 = Color(0x4DFFFFFF);
  static const Color white80 = Color(0xCCFFFFFF);
}

class AppGradients {
  // Gradien Tombol (Metallic Rose Gold)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFC78B6E), Color(0xFFE5B59C)],
    begin: Alignment.centerLeft, 
    end: Alignment.centerRight,
  );

  // Gradien untuk Kotak Ikon / Badge (Navy Blue Metallic)
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF213D63), Color(0xFF12233D)],
    begin: Alignment.topLeft, 
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkOverlay = LinearGradient(
    colors: [Color(0xB3000000), Color(0x80000000), Color(0xFF000000)],
    begin: Alignment.topCenter, 
    end: Alignment.bottomCenter, 
    stops: [0.0, 0.5, 1.0],
  );

  // Gradien Tuts Piano Virtual (Disesuaikan dengan Navy)
  static const LinearGradient pianoKeyGradient = LinearGradient(
    colors: [Color(0xFF162945), Color(0xFF08121F)],
    begin: Alignment.topCenter, 
    end: Alignment.bottomCenter,
  );

  // Gradien Kartu (Dark Navy)
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF122138), Color(0xFF0B1627)],
    begin: Alignment.topLeft, 
    end: Alignment.bottomRight,
  );
}

class AppTextStyles {
  static const TextStyle display = TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.1, letterSpacing: -2);
  static const TextStyle heading1 = TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.1, letterSpacing: -1);
  static const TextStyle heading2 = TextStyle(fontSize: 36, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.2);
  static const TextStyle heading3 = TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.3);
  static const TextStyle body = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textSecondary, height: 1.6);
  static const TextStyle bodySmall = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textSecondary, height: 1.5);
  static const TextStyle label = TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textMuted, letterSpacing: 0.5);
  static const TextStyle button = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary, letterSpacing: 0.2);
  static const TextStyle navLink = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.white80);
  static const TextStyle price = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.2);
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double pill = 999.0;
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}