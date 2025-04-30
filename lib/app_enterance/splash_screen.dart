import 'dart:async';
import 'package:akshaya_flutter/app_enterance/language_screen.dart';
import 'package:akshaya_flutter/authentication/login_screen.dart';
import 'package:akshaya_flutter/common_utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/main_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoScaleAnimation;
  late AnimationController _bgController;
  late Animation<double> _bgFadeAnimation;
  bool isLogin = false;
  bool welcome = false;
  int langID = 0;
  @override
  void initState() {
    super.initState();
    loadData();
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    // App logo scale animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _logoScaleAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Background fade animation
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _bgFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeIn),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
  navigateToNextScreen();
      }
    });
    _animationController.forward();
    _bgController.forward();
  }
  void navigateToNextScreen() {
    if (isLogin) {
      // Navigate to home screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
      //  context.go(Routes.homeScreen.path);
    } else {
      if (welcome) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
        //     context.go(Routes.loginScreen.path);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LanguageScreen(),
          ),
        );
        // context.go(Routes.languageScreen.path);
      }
    }
  }


  @override
  void dispose() {
    _animationController.dispose();
    _bgController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF1E0),
      body: Stack(
        children: [
          // Background Image
          FadeTransition(
            opacity: _bgFadeAnimation,
            child: Center(
              child: Image.asset(
                'assets/images/palmmitra_splash.png',
                width: size.width,
                height: size.width,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Centered Logo and Text
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Logo
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: Image.asset(
                          'assets/images/palm360_logo.png',
                          width: 180,
                          height: 180,
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 20),

                  // Clean Text

                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.6,
            left: size.width * 0.4,

            child: const TypewriterText(
            text: "Palm Mithra",
            color: Color(0xFFCE0E2D),
          ),)

        ],
      ),
    );
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool(Constants.isLogin) ?? false;
      welcome = prefs.getBool(Constants.welcome) ?? false;
      langID = prefs.getInt("lang") ?? 0;
    });
  }
}

/*
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isLogin = false;
  bool welcome = false;
  int langID = 0;

  late Animation<double> _logoScaleAnimation;
  late AnimationController _bgController;
  late Animation<double> _bgFadeAnimation;
  @override
  void initState() {
    super.initState();
    loadData();
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

*/
/*    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigateToNextScreen();
      }
    });*//*


//    _animationController.forward();

 //App logo scale animation
    _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Background fade animation
    _bgController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
    );

    _bgFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(parent: _bgController, curve: Curves.easeIn),
    );

    _animationController.forward();
    _bgController.forward();
  }

  void navigateToNextScreen() {
    if (isLogin) {
      // Navigate to home screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
      //  context.go(Routes.homeScreen.path);
    } else {
      if (welcome) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
        //     context.go(Routes.loginScreen.path);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LanguageScreen(),
          ),
        );
        // context.go(Routes.languageScreen.path);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child:  SizedBox(
        height: size.height,
        child: Stack(
        children: [
        // Solid Background Color
        Container(
        color: const Color(0xFFFFF1E0),
    ),

    // Animated Background Image
    FadeTransition(
    opacity: _bgFadeAnimation,
    child: Center(
    child: Image.asset(
    'assets/images/palm-mitra-splash.png', // Use your uploaded image
    width: size.width * 0.8,
    height: size.width * 0.8,
    fit: BoxFit.contain,
    ),
    ),
    ),

    // Foreground logo and text
    Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    // App logo with scale animation
    AnimatedBuilder(
    animation: _animationController,
    builder: (context, child) {
    return Transform.scale(
    scale: _logoScaleAnimation.value,
    child: Image.asset(
    'assets/images/palm360_logo.png',
    width: 150,
    height: 150,
    ),
    );
    },
    ),
    const SizedBox(height: 16),

    const TypewriterText(
    text: "Welcome to Palm Mithra",
    color: Color(0xFFCE0E2D),
    ),
    ],
    ),
    ),
    ],


      ),
    )));
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool(Constants.isLogin) ?? false;
      welcome = prefs.getBool(Constants.welcome) ?? false;
      langID = prefs.getInt("lang") ?? 0;
    });
  }
}
*/
class TypewriterText extends StatefulWidget {
  final String text;
  final Color color;
  final double? fontSize;

  const TypewriterText({
    super.key,
    required this.text,
    required this.color,
    this.fontSize = 24,
  });

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = ""; // Initial empty text
  int _index = 0; // Index for tracking characters

  @override
  void initState() {
    super.initState();
    // Start the typewriter animation
    _startTypewriterAnimation();
  }

  void _startTypewriterAnimation() {
    const Duration duration = Duration(milliseconds: 100);

    Timer.periodic(duration, (Timer timer) {
      if (_index < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_index];
          _index++;
        });
      } else {
        // Text animation completed, cancel the timer
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          _displayedText,
          style: TextStyle(
            fontSize: widget.fontSize,
            fontFamily: 'hind_semibold',
            color: widget.color, // Use the provided text color
          ),
        ),
      ),
    );
  }
}

