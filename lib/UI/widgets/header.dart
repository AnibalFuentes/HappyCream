import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/UI/pages/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class HeaderDesing extends StatefulWidget {
  const HeaderDesing({super.key});

  @override
  State<HeaderDesing> createState() => _HeaderDesingState();
}

class _HeaderDesingState extends State<HeaderDesing> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: CustomPaint(
              painter: _HeaderDesingPainter(),
            ),
          ),
          SizedBox.expand(
            child: CustomPaint(
              painter: _HeaderDesingPainter2(),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.26,
                  child: Image.asset('assets/icon/icon.png'),
                ),
                const SizedBox(height: 20),
                SwipeableButtonView(
                  
                  onFinish: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        child: const LoginPage(),
                        type: PageTransitionType.fade,
                      ),
                    );
                    setState(() {
                      isFinished = false;
                    });
                  },
                  onWaitingProcess: () {
                    Future.delayed(const Duration(milliseconds: 800), () {
                      setState(() {
                        isFinished = true;
                      });
                    });
                  },
                  activeColor: Colors.deepPurpleAccent,
                  isFinished: isFinished,
                  buttonWidget:
                      const Icon(Icons.arrow_forward, color: Colors.grey),
                  buttonText: 'Desliza para ir al menu',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderDesingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, size.height * 0.22)
      ..quadraticBezierTo(size.width * 0.2, size.height * 0.35,
          size.width * 0.53, size.height * 0.22)
      ..quadraticBezierTo(
          size.width * 0.8, size.height * 0.1, size.width, size.height * 0.15)
      ..lineTo(size.width, 0)
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0.78)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.65,
          size.width * 0.47, size.height * 0.78)
      ..quadraticBezierTo(
          size.width * 0.2, size.height * 0.9, 0, size.height * 0.85)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeaderDesingPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.22)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.35,
          size.width * 0.45, size.height * 0.22)
      ..quadraticBezierTo(
          size.width * 0.1, size.height * 0.1, 0, size.height * 0.15)
      ..lineTo(0, 0)
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.78)
      ..quadraticBezierTo(size.width * 0.2, size.height * 0.65,
          size.width * 0.55, size.height * 0.78)
      ..quadraticBezierTo(
          size.width * 0.9, size.height * 0.9, size.width, size.height * 0.85)
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
