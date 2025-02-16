import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.label,
    this.color,
    this.labelColor,
    this.gradient,
    this.height,
    this.width,
    this.labelSize,
    this.suffix,
    this.leading,
    this.borderRadius,
    this.border,
    super.key,
  });

  final VoidCallback onPressed;
  final String label;
  final Color? color;
  final Color? labelColor;
  final Gradient? gradient;
  final double? height;
  final double? width;
  final double? labelSize;
  final Widget? suffix;
  final Widget? leading;
  final BorderRadius? borderRadius;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.blueAccent,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        border: border,
      ),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
          FocusScope.of(context).unfocus();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 8),
            ],
            Text(label),
            if (suffix != null) ...[
              const SizedBox(
                width: 16,
              ),
              suffix!,
            ]
          ],
        ),
      ),
    );
  }
}
