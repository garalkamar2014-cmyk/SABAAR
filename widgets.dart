import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ── Pill / Badge ──────────────────────────────────────────────────────
class AppPill extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final double fontSize;

  const AppPill({
    super.key,
    required this.text,
    this.bgColor = AppTheme.navy,
    this.textColor = Colors.white,
    this.fontSize = 9,
  });

  factory AppPill.lime(String text) => AppPill(
        text: text,
        bgColor: AppTheme.lime,
        textColor: AppTheme.limeText,
      );

  factory AppPill.teal(String text) => AppPill(
        text: text,
        bgColor: AppTheme.teal,
        textColor: const Color(0xFF0A3028),
      );

  factory AppPill.navy(String text) => const AppPill(text: '');

  factory AppPill.gray(String text) => AppPill(
        text: text,
        bgColor: const Color(0xFFE0E2DC),
        textColor: const Color(0xFF555555),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// ── Arrow Button ──────────────────────────────────────────────────────
class ArrowButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;

  const ArrowButton({super.key, this.onTap, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppTheme.teal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.arrow_outward,
          color: Colors.white,
          size: size * 0.5,
        ),
      ),
    );
  }
}

// ── Progress Bar ──────────────────────────────────────────────────────
class AppProgressBar extends StatelessWidget {
  final double value;

  const AppProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: const Color(0xFFEAECE6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.teal,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 5),
          child: value > 0.1
              ? Text(
                  '${(value * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

// ── Section Title ─────────────────────────────────────────────────────
class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: AppTheme.navy,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ── App Text Field ────────────────────────────────────────────────────
class AppTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final int maxLines;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final bool readOnly;

  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onTap: onTap,
      readOnly: readOnly,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppTheme.navy,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppTheme.navy.withOpacity(0.3),
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppTheme.navy.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppTheme.navy.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

// ── App Header ────────────────────────────────────────────────────────
class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.headerDecoration,
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.navy.withOpacity(0.55),
                      letterSpacing: 0.4,
                    ),
                  ),
                Text(title, style: AppTheme.heading1),
              ],
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────
class AppAvatar extends StatelessWidget {
  final String initials;
  final double size;

  const AppAvatar({super.key, this.initials = 'AA', this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppTheme.navy,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: GoogleFonts.inter(
          fontSize: size * 0.3,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ── Floating Glass Nav ────────────────────────────────────────────────
class GlassNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onPlusTap;

  const GlassNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onPlusTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 14,
      left: 14,
      right: 14,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.28),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white.withOpacity(0.55)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.navy.withOpacity(0.12),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: BackdropFilter(
            filter: ColorFilter.mode(
              Colors.white.withOpacity(0.1),
              BlendMode.lighten,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavIcon(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  _NavIcon(
                    icon: Icons.folder_outlined,
                    activeIcon: Icons.folder_rounded,
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  _PlusButton(onTap: onPlusTap),
                  _NavIcon(
                    icon: Icons.receipt_long_outlined,
                    activeIcon: Icons.receipt_long_rounded,
                    isActive: currentIndex == 2,
                    onTap: () => onTap(2),
                  ),
                  _NavIcon(
                    icon: Icons.language_outlined,
                    activeIcon: Icons.language_rounded,
                    isActive: currentIndex == 3,
                    onTap: () => onTap(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isActive ? AppTheme.navy : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          color: isActive ? Colors.white : AppTheme.navy,
          size: 22,
        ),
      ),
    );
  }
}

class _PlusButton extends StatelessWidget {
  final VoidCallback onTap;
  const _PlusButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppTheme.navy,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppTheme.navy.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 22),
      ),
    );
  }
}

// ── Add Menu Overlay ──────────────────────────────────────────────────
class AddMenuOverlay extends StatelessWidget {
  final bool showNewSpace;
  final VoidCallback onNewProject;
  final VoidCallback onNewInvoice;
  final VoidCallback onAiMode;
  final VoidCallback onNewSpace;
  final VoidCallback onDismiss;

  const AddMenuOverlay({
    super.key,
    this.showNewSpace = false,
    required this.onNewProject,
    required this.onNewInvoice,
    required this.onAiMode,
    required this.onNewSpace,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: onDismiss,
        child: Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 14, bottom: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: showNewSpace
                    ? [_MenuItem('NEW SPACE', Icons.language, onNewSpace)]
                    : [
                        _MenuItem('NEW PROJECT', Icons.note_add_outlined, onNewProject),
                        const SizedBox(height: 8),
                        _MenuItem('NEW INVOICE', Icons.receipt_outlined, onNewInvoice),
                        const SizedBox(height: 8),
                        _MenuItem('AI MODE', Icons.mic_outlined, onAiMode),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuItem(this.label, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.navy,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.navy.withOpacity(0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.navy.withOpacity(0.15),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: AppTheme.navy, size: 20),
          ),
        ],
      ),
    );
  }
}
