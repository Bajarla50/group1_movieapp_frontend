import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _logoOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _circleAnimation = Tween<double>(
      begin: 0,
      end: 2000,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
    ));

    _controller.forward();

    Timer(const Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5C67D1),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                      opacity: _logoOpacityAnimation.value,
                      child: Image.asset(
                        'assets/Popcorn.png',
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.6,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.002),
                    Opacity(
                      opacity: _logoOpacityAnimation.value,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'M',
                                style: TextStyle(
                                  fontFamily: 'MuseoModerno',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.12,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              TextSpan(
                                text: 'ovie ',
                                style: TextStyle(
                                  fontFamily: 'MuseoModerno',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              TextSpan(
                                text: 'M',
                                style: TextStyle(
                                  fontFamily: 'MuseoModerno',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.12,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              TextSpan(
                                text: 'unch',
                                style: TextStyle(
                                  fontFamily: 'MuseoModerno',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
