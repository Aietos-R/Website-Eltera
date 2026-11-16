import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/components.dart';
import '../widgets/navbar.dart'; 
import '../widgets/footer.dart'; 

class LandingPage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const LandingPage({super.key, this.userData});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _coursesKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _testimoniKey = GlobalKey();

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _HeroSection(userData: widget.userData),
                _FeaturesSection(),
                _CoursesSection(key: _coursesKey),
                _GallerySection(key: _galleryKey),
                _TestimoniSection(key: _testimoniKey),
                Footer(
                  onKursus: () => _scrollToKey(_coursesKey),
                  onGaleri: () => _scrollToKey(_galleryKey),
                  onTestimoni: () => _scrollToKey(_testimoniKey),
                ),
              ],
            ),
          ),
          
          // NAVBAR MELAYANG OVAL
          Positioned(
            top: 24,
            left: AppSpacing.lg, right: AppSpacing.lg,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: NavBar(
                  userData: widget.userData,
                  onKursus: () => _scrollToKey(_coursesKey),
                  onGaleri: () => _scrollToKey(_galleryKey),
                  onTestimoni: () => _scrollToKey(_testimoniKey),
                  scrollController: _scrollController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// KONTEN HALAMAN 
class _HeroSection extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const _HeroSection({this.userData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrow = screenWidth < 600;

    return Container(
      width: double.infinity, 
      constraints: BoxConstraints(minHeight: isNarrow ? 600 : 780),
      child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  image: DecorationImage(
                    image: const AssetImage('images/background.jpg'), 
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.2), BlendMode.darken), 
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0, left: 0, right: 0, height: 200,
            child: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, AppColors.background], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isNarrow ? AppSpacing.lg : AppSpacing.xxxl, vertical: 180),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo_eltera.png', height:200,
                    errorBuilder: (context, error, stackTrace) => Container(width: 36, height: 36, decoration: BoxDecoration(gradient: AppGradients.heroGradient, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.music_note_rounded, color: Colors.white, size: 20)),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(userData != null ? 'Selamat Datang,\n${userData!['nama_user']}!' : 'Maestro Piano', style: TextStyle(fontSize: isNarrow ? 42 : 80, fontWeight: FontWeight.bold, color: Colors.white, height: 1.05, letterSpacing: -2), textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.lg),
                  ConstrainedBox(constraints: const BoxConstraints(maxWidth: 560), child: Text('Rasakan pengalaman belajar piano yang berbeda. Dari pemula hingga profesional, kami siap membimbing perjalanan musikmu.', style: TextStyle(fontSize: isNarrow ? 15 : 18, color: AppColors.white80, height: 1.7), textAlign: TextAlign.center)),
                  const SizedBox(height: AppSpacing.xxl),
                  Wrap(spacing: AppSpacing.md, runSpacing: AppSpacing.md, alignment: WrapAlignment.center, children: [GradientButton(text: 'Mulai Belajar', width: 160, height: 52, onPressed: () {}), OutlinedGlassButton(text: 'Lihat Demo', width: 150, height: 52, onPressed: () {})]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;
    final features = [
      {'icon': Icons.school_rounded, 'title': 'Instruktur Berpengalaman', 'description': 'Belajar dari guru piano profesional dengan sertifikasi internasional dan pengalaman mengajar.'},
      {'icon': Icons.calendar_today_rounded, 'title': 'Jadwal Fleksibel', 'description': 'Atur jadwal belajar sesuai dengan waktu luang Anda. Tersedia sesi pagi, siang, dan malam hari.'},
      {'icon': Icons.workspace_premium_rounded, 'title': 'Sertifikat Resmi', 'description': 'Dapatkan sertifikat resmi setelah menyelesaikan setiap level kursus yang diakui secara nasional.'},
    ];

    return Container(
      width: double.infinity, padding: EdgeInsets.symmetric(horizontal: isNarrow ? AppSpacing.lg : AppSpacing.xxxl, vertical: AppSpacing.xxl),
      child: Column(
        children: [
          const SectionTitle(title: 'Mengapa Memilih Kami?', subtitle: 'Pengalaman belajar piano terbaik untuk Anda'),
          const SizedBox(height: AppSpacing.xxl),
          if (isNarrow)
            Column(children: features.map((f) => Padding(padding: const EdgeInsets.only(bottom: AppSpacing.lg), child: FeatureCard(icon: f['icon'] as IconData, title: f['title'] as String, description: f['description'] as String))).toList())
          else
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Memaksa anak untuk setinggi kartu tertinggi
                children: features.asMap().entries.map((entry) => Expanded(child: Padding(padding: EdgeInsets.only(right: entry.key < features.length - 1 ? AppSpacing.lg : 0), child: FeatureCard(icon: entry.value['icon'] as IconData, title: entry.value['title'] as String, description: entry.value['description'] as String)))).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _CoursesSection extends StatelessWidget {
  const _CoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;
    
    final courses = [
      {'level': 'Beginner', 'levelLabel': 'Beginner', 'title': 'Kelas Pemula', 'duration': '3 Bulan', 'price': 'Rp x.x00.000', 'description': 'Belajar dasar-dasar piano dari awal dengan metode yang mudah dipahami.'},
      {'level': 'Intermediate', 'levelLabel': 'Intermediate', 'title': 'Kelas Menengah', 'duration': '6 Bulan', 'price': 'Rp x.x00.000', 'description': 'Tingkatkan kemampuan bermain piano dengan teknik dan repertoire yang kompleks.'},
      {'level': 'Advanced', 'levelLabel': 'Advanced', 'title': 'Kelas Lanjutan', 'duration': '12 Bulan', 'price': 'Rp x.000.000', 'description': 'Program intensif untuk persiapan konser dan kompetisi tingkat nasional.'},
    ];

    return Container(
      width: double.infinity, padding: EdgeInsets.symmetric(horizontal: isNarrow ? AppSpacing.lg : AppSpacing.xxxl, vertical: AppSpacing.xxl),
      child: Column(
        children: [
          const SectionTitle(title: 'Program Kursus', subtitle: 'Pilih program yang sesuai dengan level kemampuan Anda'),
          const SizedBox(height: AppSpacing.xxl),
          if (isNarrow)
            Column(children: courses.map((c) => Padding(padding: const EdgeInsets.only(bottom: AppSpacing.lg), child: CourseCard(level: c['level']!, levelLabel: c['levelLabel']!, title: c['title']!, duration: c['duration']!, price: c['price']!, description: c['description']!))).toList())
          else
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: courses.asMap().entries.map((entry) => Expanded(child: Padding(padding: EdgeInsets.only(right: entry.key < courses.length - 1 ? AppSpacing.lg : 0), child: CourseCard(level: entry.value['level']!, levelLabel: entry.value['levelLabel']!, title: entry.value['title']!, duration: entry.value['duration']!, price: entry.value['price']!, description: entry.value['description']!)))).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _GallerySection extends StatefulWidget {
  const _GallerySection({super.key});
  @override State<_GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<_GallerySection> {
  int _currentIndex = 0;
  final List<Map<String, dynamic>> _galleryItems = [
    {'icon': Icons.piano_rounded, 'label': 'Ruang Kelas Utama', 'color': const Color(0xFF6B48FF)},
    {'icon': Icons.music_note_rounded, 'label': 'Sesi Latihan', 'color': const Color(0xFFAD46FF)},
    {'icon': Icons.people_alt_rounded, 'label': 'Konser Mini', 'color': const Color(0xFFF6339A)},
  ];

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 600;
    return Container(
      width: double.infinity, padding: EdgeInsets.symmetric(horizontal: isNarrow ? AppSpacing.lg : AppSpacing.xxxl, vertical: AppSpacing.xxl),
      child: Column(
        children: [
          const SectionTitle(title: 'Galeri Kami', subtitle: 'Lihat suasana belajar dan fasilitas kami'),
          const SizedBox(height: AppSpacing.xxl),
          Container(
            height: 280,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [(_galleryItems[_currentIndex]['color'] as Color).withValues(alpha: 0.3), AppColors.surfaceLight], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(AppRadius.xl), border: Border.all(color: AppColors.border, width: 1)),
            child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(_galleryItems[_currentIndex]['icon'] as IconData, size: 80, color: _galleryItems[_currentIndex]['color'] as Color), const SizedBox(height: AppSpacing.md), Text(_galleryItems[_currentIndex]['label'] as String, style: AppTextStyles.heading3)])),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GalleryNavButton(icon: Icons.arrow_back_rounded, onTap: () => setState(() => _currentIndex = (_currentIndex - 1 + _galleryItems.length) % _galleryItems.length)),
              const SizedBox(width: AppSpacing.md),
              GalleryNavButton(icon: Icons.arrow_forward_rounded, onTap: () => setState(() => _currentIndex = (_currentIndex + 1) % _galleryItems.length)),
            ],
          )
        ],
      ),
    );
  }
}

class _TestimoniSection extends StatelessWidget {
  const _TestimoniSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;
    final testimonials = [
      {'name': 'Sarah Amanda', 'classLevel': 'Murid Kelas Menengah', 'review': 'Pengalaman belajar yang luar biasa! Instruktur sangat sabar dan metode pengajarannya sangat efektif.', 'rating': 5},
      {'name': 'David Prasetyo', 'classLevel': 'Murid Kelas Lanjutan', 'review': 'Fasilitas yang sangat lengkap dan suasana belajar yang menyenangkan. Lolos audisi berkat bimbingan di sini.', 'rating': 5},
    ];

    return Container(
      width: double.infinity, padding: EdgeInsets.symmetric(horizontal: isNarrow ? AppSpacing.lg : AppSpacing.xxxl, vertical: AppSpacing.xxl), decoration: const BoxDecoration(color: AppColors.surface),
      child: Column(
        children: [
          const SectionTitle(title: 'Testimoni Murid Kami', subtitle: 'Pengalaman belajar piano dari para murid kami'),
          const SizedBox(height: AppSpacing.xxl),
          if (isNarrow)
            Column(children: testimonials.map((t) => Padding(padding: const EdgeInsets.only(bottom: AppSpacing.lg), child: TestimonialCard(name: t['name'] as String, classLevel: t['classLevel'] as String, review: t['review'] as String, rating: t['rating'] as int))).toList())
          else
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: testimonials.asMap().entries.map((entry) => Expanded(child: Padding(padding: EdgeInsets.only(right: entry.key < testimonials.length - 1 ? AppSpacing.lg : 0), child: TestimonialCard(name: entry.value['name'] as String, classLevel: entry.value['classLevel'] as String, review: entry.value['review'] as String, rating: entry.value['rating'] as int)))).toList()),
        ],
      ),
    );
  }
}