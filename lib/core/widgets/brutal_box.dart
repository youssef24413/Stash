import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_tokens.dart';

class BrutalBox extends StatefulWidget {
  const BrutalBox({
    super.key,
    required this.child,
    this.color = AppColors.surface,
    this.padding = const EdgeInsets.all(AppSpace.md),
    this.radius = AppRadius.md,
    this.onTap,
  });

  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double radius;
  final VoidCallback? onTap;

  @override
  State<BrutalBox> createState() => _BrutalBoxState();
}

class _BrutalBoxState extends State<BrutalBox> {
  bool _pressed = false;

  void _set(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    const offset = AppBrutal.shadowOffset;

    final box = AnimatedContainer(
      duration: const Duration(milliseconds: 90),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(
        _pressed ? offset.dx : 0,
        _pressed ? offset.dy : 0,
        0,
      ),
      padding: widget.padding,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.radius),
        border: Border.all(color: AppColors.ink, width: AppBrutal.border),
        boxShadow: _pressed
            ? const []
            : const [BoxShadow(color: AppColors.ink, offset: offset)],
      ),
      child: widget.child,
    );

    if (widget.onTap == null) return box;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _set(true),
      onTapUp: (_) => _set(false),
      onTapCancel: () => _set(false),
      onTap: () {
        HapticFeedback.selectionClick();
        widget.onTap!();
      },
      child: box,
    );
  }
}
