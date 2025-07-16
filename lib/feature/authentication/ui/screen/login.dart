import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:inventorymanagement/common/utils/form_validation.dart';
import 'package:inventorymanagement/common/utils/textfield.dart';
import 'package:inventorymanagement/feature/authentication/ui/screen/forget_password.dart';
import 'package:inventorymanagement/feature/dashboard/ui/screen/dashboard.dart';
import 'package:inventorymanagement/feature/provider/authstate.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<Authstate>(builder: (
      context,
      authstate,
      _,
    ) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 100,
                      width: 250,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Welcome Back text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Login into your account",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email & Password Fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        buildLabeledField(
                          label: "Email Address",
                          controller: authstate.loginemailController,
                          validator: CustomValidator.validateEmail,
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 20),
                        buildLabeledField(
                          label: "Password",
                          controller: authstate.loginpasswordController,
                          validator: CustomValidator.validatePassword,
                          icon: Icons.lock,
                          obscureText: true,
                        ),

                        // Forgot password link
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Continue Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: authstate.loginemailController.text
                                        .trim(),
                                    password: authstate
                                        .loginpasswordController.text
                                        .trim(),
                                  );

                                  print(
                                      "Login successful: ${credential.user?.email}");

                                  if (mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DashbaordScreen()),
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  String message = '';
                                  if (e.code == 'user-not-found') {
                                    message = 'No user found for that email.';
                                  } else if (e.code == 'wrong-password') {
                                    message = 'Wrong password provided.';
                                  } else {
                                    message =
                                        'Something went wrong. ${e.message}';
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Continue",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
