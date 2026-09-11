import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.onFinished,
  });

  final VoidCallback onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
      const Duration(seconds: 5),
      widget.onFinished,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -size.width * 0.25,
              right: -size.width * 0.2,
              child: _GlowCircle(
                size: size.width * 0.65,
                opacity: 0.10,
              ),
            ),
            Positioned(
              bottom: -size.width * 0.30,
              left: -size.width * 0.25,
              child: _GlowCircle(
                size: size.width * 0.75,
                opacity: 0.08,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _LogoMark()
                        .animate()
                        .scale(
                          duration: 700.ms,
                          curve: Curves.easeOutBack,
                        )
                        .fadeIn(duration: 500.ms),
                    const SizedBox(height: 28),
                    Text(
                      'ResourceX',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                      ),
                    )
                        .animate()
                        .fadeIn(
                          delay: 350.ms,
                          duration: 700.ms,
                        )
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          delay: 350.ms,
                          duration: 700.ms,
                          curve: Curves.easeOut,
                        ),
                    const SizedBox(height: 10),
                    Text(
                      'Turn surplus into impact.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.82),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                    )
                        .animate()
                        .fadeIn(
                          delay: 700.ms,
                          duration: 700.ms,
                        ),
                    const SizedBox(height: 42),
                    const SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        minHeight: 3,
                        backgroundColor: Color(0x40FFFFFF),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(
                          delay: 1000.ms,
                          duration: 500.ms,
                        )
                        .shimmer(
                          delay: 1200.ms,
                          duration: 1600.ms,
                        ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 28,
              child: Text(
                'SMART RESOURCE EXCHANGE',
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.55),
                  letterSpacing: 2.2,
                  fontWeight: FontWeight.w600,
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: 1200.ms,
                    duration: 800.ms,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.autorenew_rounded,
          size: 52,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({
    required this.size,
    required this.opacity,
  });

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}