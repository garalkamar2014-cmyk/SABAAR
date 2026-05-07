import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const MainShell(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFCCE8DE), Color(0xFFE4ECE0), Color(0xFFD8E8D0)],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Cactus Logo
                _CactusLogo(),
                const SizedBox(height: 16),
                Text(
                  'SABAAR',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.navy,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'صبار',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.teal,
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

class _CactusLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(80, 90),
      painter: _CactusPainter(),
    );
  }
}

class _CactusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppTheme.navy;
    final dotPaint = Paint()..color = const Color(0xFFE8EBE4);

    // Main body
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.4, size.height * 0.05,
          size.width * 0.22, size.height * 0.65),
      const Radius.circular(11),
    );
    canvas.drawRRect(body, paint);

    // Left arm
    final leftArm = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.1, size.height * 0.25,
          size.width * 0.35, size.height * 0.17),
      const Radius.circular(9),
    );
    canvas.drawRRect(leftArm, paint);

    // Right arm
    final rightArm = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.55, size.height * 0.38,
          size.width * 0.35, size.height * 0.17),
      const Radius.circular(9),
    );
    canvas.drawRRect(rightArm, paint);

    // Dots
    final dots = [
      Offset(size.width * 0.51, size.height * 0.28),
      Offset(size.width * 0.51, size.height * 0.44),
      Offset(size.width * 0.51, size.height * 0.60),
    ];
    for (final d in dots) {
      canvas.drawCircle(d, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
