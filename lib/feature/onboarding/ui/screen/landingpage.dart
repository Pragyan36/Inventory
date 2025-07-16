import 'package:flutter/material.dart';
import 'package:inventorymanagement/feature/authentication/ui/screen/login.dart';
import 'package:inventorymanagement/feature/authentication/ui/screen/signup.dart';
import 'package:inventorymanagement/feature/onboarding/ui/widget/onboardpage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: screenHeight * (1.7 / 4),
                color: Colors.grey[900],
              ),
              Container(
                height: screenHeight * (1.5 / 4),
                color: Colors.black,
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                flex: 6,
                child: PageView(
                  children: [
                    onboardPage(
                      imagePath: 'assets/onboarding.png',
                      screenHeight: screenHeight,
                      tag: "Business Inventory\nMade Simple",
                      activeIndex: 0,
                    ),
                    onboardPage(
                      imagePath: 'assets/onboarding2.png',
                      screenHeight: screenHeight,
                      tag: "Stay Organized Always",
                      activeIndex: 1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF4A57),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.white70),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
