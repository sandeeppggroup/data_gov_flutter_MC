import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[900]!, Colors.blue[300]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              _buildLogo(),
              const SizedBox(height: 40),
              _buildAnimatedTitle(),
              const SizedBox(height: 20),
              _buildSubtitle(context),
              const SizedBox(height: 60),
              _buildExploreButton(context),
              const Spacer(),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Hero(
      tag: 'logo',
      child: SvgPicture.asset(
        'assets/images/india.svg', // Make sure to add this SVG file to your assets
        height: 150,
        color : Colors.white,
      ),
    );
  }

  Widget _buildAnimatedTitle() {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText('IndiaDataViz'),
        ],
        isRepeatingAnimation: false,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        'Explore Indian government data through interactive charts',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildExploreButton(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: ElevatedButton(
        onPressed: () {
          context.go('/chart');
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blue[700],
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        child: const Text('Explore Data'),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        '© 2024 IndiaDataViz',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white70,
            ),
      ),
    );
  }
}