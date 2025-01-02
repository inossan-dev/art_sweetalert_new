import 'package:art_sweetalert_new/art_sweetalert_new.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArtAlertIcon extends StatefulWidget {
  final ArtAlertType type;
  final double size;
  final Duration animationDuration;

  const ArtAlertIcon({
    super.key,
    required this.type,
    this.size = 80.0,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  State<ArtAlertIcon> createState() => _ArtAlertIconState();
}

class _ArtAlertIconState extends State<ArtAlertIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _IconPainter(
                type: widget.type,
                animation: _controller,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _IconPainter extends CustomPainter {
  final ArtAlertType type;
  final Animation<double> animation;

  _IconPainter({required this.type, required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    final Paint circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final Paint fillPaint = Paint()
      ..style = PaintingStyle.fill;

    switch (type) {
      case ArtAlertType.success:
        _drawSuccess(canvas, size, center, radius, circlePaint, fillPaint);
        break;
      case ArtAlertType.error:
        _drawError(canvas, size, center, radius, circlePaint, fillPaint);
        break;
      case ArtAlertType.warning:
        _drawWarning(canvas, size, center, radius, circlePaint, fillPaint);
        break;
      case ArtAlertType.info:
        _drawInfo(canvas, size, center, radius, circlePaint, fillPaint);
        break;
      case ArtAlertType.question:
        _drawQuestion(canvas, size, center, radius, circlePaint, fillPaint);
        break;
    }
  }

  void _drawSuccess(Canvas canvas, Size size, Offset center, double radius, Paint circlePaint, Paint fillPaint) {
    circlePaint.color = Colors.green.withOpacity(0.3);
    fillPaint.color = Colors.green;

    // Draw circle
    canvas.drawCircle(center, radius, circlePaint);

    // Draw checkmark
    final Path checkPath = Path();
    final double startX = size.width * 0.25;
    final double startY = size.height * 0.5;

    checkPath.moveTo(startX, startY);
    checkPath.lineTo(size.width * 0.45, size.height * 0.7);
    checkPath.lineTo(size.width * 0.75, size.height * 0.3);

    canvas.drawPath(
      checkPath,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.green
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawError(Canvas canvas, Size size, Offset center, double radius,
      Paint circlePaint, Paint fillPaint) {
    circlePaint.color = Colors.red.withOpacity(0.3);
    fillPaint.color = Colors.red;

    // Draw circle
    canvas.drawCircle(center, radius, circlePaint);

    // Draw X
    final Paint crossPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.3),
      Offset(size.width * 0.7, size.height * 0.7),
      crossPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.7),
      Offset(size.width * 0.7, size.height * 0.3),
      crossPaint,
    );
  }

  void _drawWarning(Canvas canvas, Size size, Offset center, double radius,
      Paint circlePaint, Paint fillPaint) {
    circlePaint.color = const Color(0xFFFACEA8).withOpacity(0.3);
    fillPaint.color = const Color(0xFFFACEA8);

    // Draw circle
    canvas.drawCircle(center, radius, circlePaint);

    // Draw exclamation mark
    final Paint exclamationPaint = Paint()
      ..color = const Color(0xFFFACEA8)
      ..style = PaintingStyle.fill;

    // Exclamation point body
    final Path exclamationPath = Path();
    exclamationPath.moveTo(size.width * 0.45, size.height * 0.25);
    exclamationPath.lineTo(size.width * 0.55, size.height * 0.25);
    exclamationPath.lineTo(size.width * 0.53, size.height * 0.55);
    exclamationPath.lineTo(size.width * 0.47, size.height * 0.55);
    exclamationPath.close();

    // Exclamation point dot
    exclamationPath.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.5, size.height * 0.7),
      radius: size.width * 0.05,
    ));

    canvas.drawPath(exclamationPath, exclamationPaint);
  }

  void _drawInfo(Canvas canvas, Size size, Offset center, double radius,
      Paint circlePaint, Paint fillPaint) {
    circlePaint.color = const Color(0xFF9DE0F6).withOpacity(0.3);
    fillPaint.color = const Color(0xFF9DE0F6);

    // Draw circle
    canvas.drawCircle(center, radius, circlePaint);

    final Paint infoPaint = Paint()
      ..color = const Color(0xFF9DE0F6)
      ..style = PaintingStyle.fill;

    // Draw 'i' dot
    canvas.drawCircle(
      Offset(center.dx, size.height * 0.3),
      size.width * 0.05,
      infoPaint,
    );

    // Draw 'i' body
    final Path infoPath = Path();
    infoPath.moveTo(size.width * 0.45, size.height * 0.45);
    infoPath.lineTo(size.width * 0.55, size.height * 0.45);
    infoPath.lineTo(size.width * 0.55, size.height * 0.75);
    infoPath.lineTo(size.width * 0.45, size.height * 0.75);
    infoPath.close();

    canvas.drawPath(infoPath, infoPaint);
  }

  void _drawQuestion(Canvas canvas, Size size, Offset center, double radius,
      Paint circlePaint, Paint fillPaint) {
    circlePaint.color = const Color(0xFF87ADBD).withOpacity(0.3);
    fillPaint.color = const Color(0xFF87ADBD);

    // Draw circle
    canvas.drawCircle(center, radius, circlePaint);

    final Paint questionPaint = Paint()
      ..color = const Color(0xFF87ADBD)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    // Draw question mark
    final Path questionPath = Path();

    // Question mark curve
    questionPath.moveTo(size.width * 0.35, size.height * 0.4);
    questionPath.quadraticBezierTo(
      size.width * 0.35, size.height * 0.3,
      size.width * 0.5, size.height * 0.3,
    );
    questionPath.quadraticBezierTo(
      size.width * 0.65, size.height * 0.3,
      size.width * 0.65, size.height * 0.4,
    );
    questionPath.quadraticBezierTo(
      size.width * 0.65, size.height * 0.5,
      size.width * 0.5, size.height * 0.5,
    );
    questionPath.lineTo(size.width * 0.5, size.height * 0.6);

    // Draw the curve with stroke
    canvas.drawPath(
      questionPath,
      questionPaint..style = PaintingStyle.stroke,
    );

    // Draw dot
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.7),
      size.width * 0.04,
      questionPaint..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}