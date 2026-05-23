import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class LoadingState extends StatefulWidget {
  const LoadingState({super.key});

  @override
  State<LoadingState> createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -60,
          left: -60,
          child: _glow(180, AppColors.accentBlue.withValues(alpha: 0.12)),
        ),
        Positioned(
          bottom: -40,
          right: -40,
          child: _glow(160, Colors.purple.withValues(alpha: 0.08)),
        ),
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.92 + (_controller.value * 0.16),
                      child: child,
                    );
                  },
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.loadingHalo.withValues(alpha: 0.5),
                    ),
                    child: Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryNavy,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Loading products...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryNavy,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Synchronizing architectural datasets',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 40),
                _SkeletonBar(width: double.infinity, height: 56),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _SkeletonBar(height: 80)),
                    const SizedBox(width: 12),
                    Expanded(child: _SkeletonBar(height: 80)),
                  ],
                ),
                const SizedBox(height: 12),
                _SkeletonBar(width: double.infinity, height: 56),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _glow(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [BoxShadow(blurRadius: 80, spreadRadius: 20, color: color)],
      ),
    );
  }
}

class _SkeletonBar extends StatefulWidget {
  final double? width;
  final double height;

  const _SkeletonBar({this.width, required this.height});

  @override
  State<_SkeletonBar> createState() => _SkeletonBarState();
}

class _SkeletonBarState extends State<_SkeletonBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color.lerp(
              AppColors.skeleton,
              AppColors.skeleton.withValues(alpha: 0.5),
              _shimmer.value,
            ),
          ),
        );
      },
    );
  }
}
