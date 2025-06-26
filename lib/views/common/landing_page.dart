import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'EduCertify',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Digital Certificate Management System',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    CustomButton(
                      text: 'Student Login',
                      onPressed: () {
                        Navigator.pushNamed(context, '/student/login');
                      },
                      color: Colors.white,
                      textColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Admin Login',
                      onPressed: () {
                        Navigator.pushNamed(context, '/admin/login');
                      },
                      color: Colors.white,
                      textColor: Theme.of(context).colorScheme.primary,
                    ),
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
