import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class NeonButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final IconData? icon;
  final double width;
  final double height;
  final bool isSecondary;

  const NeonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.neonCyan,
    this.icon,
    this.width = 220,
    this.height = 54,
    this.isSecondary = false,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.isSecondary ? AppColors.neonPurple : widget.color;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : (_isHovered ? 1.04 : 1.0),
          duration: const Duration(milliseconds: 120),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.isSecondary
                  ? AppColors.cardBg.withOpacity(0.8)
                  : effectiveColor.withOpacity(_isHovered ? 0.25 : 0.15),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: _isHovered ? Colors.white : effectiveColor,
                width: _isHovered ? 2.5 : 1.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: effectiveColor.withOpacity(_isHovered ? 0.8 : 0.4),
                  blurRadius: _isHovered ? 20 : 10,
                  spreadRadius: _isHovered ? 2 : 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: _isHovered ? Colors.white : effectiveColor,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.text.toUpperCase(),
                  style: GoogleFonts.orbitron(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: _isHovered ? Colors.white : AppColors.textPrimary,
                    shadows: [
                      Shadow(
                        color: effectiveColor,
                        blurRadius: _isHovered ? 12 : 6,
                      ),
                    ],
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
