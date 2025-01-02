import 'package:art_sweetalert_new/art_sweetalert_new.dart';
import 'package:flutter/material.dart';

class ArtSweetAlert extends StatelessWidget {
  final Widget title;
  final Widget? content;
  final ArtAlertType? type;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final Duration animationDuration;
  final bool barrierDismissible;
  final Color backgroundColor;
  final double borderRadius;

  const ArtSweetAlert({
    super.key,
    required this.title,
    this.content,
    this.type,
    this.actions,
    this.padding = const EdgeInsets.all(24),
    this.iconSize = 80,
    this.animationDuration = const Duration(milliseconds: 600),
    this.barrierDismissible = true,
    this.backgroundColor = Colors.white,
    this.borderRadius = 8,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget title,
    Widget? content,
    ArtAlertType? type,
    List<Widget>? actions,
    bool? barrierDismissible,
    double? iconSize,
    Color? backgroundColor,
    double? borderRadius,
    Duration? animationDuration,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: animationDuration ?? const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ArtSweetAlert(
          title: title,
          content: content,
          type: type,
          actions: actions,
          iconSize: iconSize ?? 80,
          backgroundColor: backgroundColor ?? Colors.white,
          borderRadius: borderRadius ?? 8,
          animationDuration: animationDuration ?? const Duration(milliseconds: 400),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (type != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ArtAlertIcon(
                    type: type!,
                    size: iconSize,
                  ),
                ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.titleLarge!,
                textAlign: TextAlign.center,
                child: title,
              ),
              if (content != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyLarge!,
                    textAlign: TextAlign.center,
                    child: content!,
                  ),
                ),
              if (actions != null)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < actions!.length; i++) ...[
                        if (i > 0) const SizedBox(width: 8),
                        actions![i],
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
