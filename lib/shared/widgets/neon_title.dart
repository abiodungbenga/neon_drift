import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class NeonTitle extends StatefulWidget {
  final String title;
  final String subtitle;
  final double fontSize;

  const NeonTitle({
    super.key,
    this.title = 'NEON DRIFT',
    this.subtitle = 'CYBER ARCADE 2099',
    this.fontSize = 42.0,
  });

  @override
  State<NeonTitle> createState() => _NeonTitleState();
}

class _NeonTitleState extends State<NeonTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 8.0, end: 24.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.neonCyan, AppColors.neonPink, AppColors.neonPurple],
              ).createShader(bounds),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: AppColors.neonCyan,
                      blurRadius: _glowAnimation.value,
                    ),
                    Shadow(
                      color: AppColors.neonPink,
                      blurRadius: _glowAnimation.value * 1.2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.subtitle.toUpperCase(),
              style: GoogleFonts.rajdhani(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 5.0,
                color: AppColors.neonCyan.withOpacity(0.8),
              ),
            ),
          ],
        );
      },
    );
  }
}
