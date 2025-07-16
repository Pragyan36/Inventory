import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventorymanagement/common/utils/form_validation.dart';
import 'package:inventorymanagement/common/utils/textfield.dart';
import 'package:inventorymanagement/feature/authentication/model/user_model.dart';
import 'package:inventorymanagement/feature/dashboard/ui/screen/dashboard.dart';
import 'package:inventorymanagement/feature/provider/authstate.dart';
import 'package:inventorymanagement/feature/provider/post_provider.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<Authstate>(builder: (
      context,
      authstate,
      _,
    ) {
      return Consumer<Poststate>(builder: (
        context,
        poststate,
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
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

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabeledField(
                            label: "Company Name",
                            controller: authstate.companyNameController,
                            validator: CustomValidator.validaterequired,
                            icon: Icons.business,
                          ),
                          const SizedBox(height: 20),
                          buildLabeledField(
                            label: "Full Name",
                            controller: authstate.fullnameController,
                            validator: CustomValidator.validateName,
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),
                          buildLabeledField(
                            label: "Email Address",
                            controller: authstate.emailController,
                            validator: CustomValidator.validateEmail,
                            icon: Icons.email,
                          ),
                          const SizedBox(height: 20),
                          buildLabeledField(
                            label: "Password",
                            controller: authstate.passwordController,
                            validator: CustomValidator.validatePassword,
                            icon: Icons.lock,
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          buildLabeledField(
                            label: "Confirm Password",
                            controller: authstate.confirmPasswordController,
                            validator: (value) =>
                                CustomValidator.validateConfirmPassword(
                                    value, authstate.passwordController.text),
                            icon: Icons.lock_outline,
                            obscureText: true,
                          ),
                          const SizedBox(height: 30),

                          // Submit button with loading
                          Center(
                            child: ElevatedButton(
                              onPressed: authstate.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          authstate.isLoading = true;
                                        });

                                        try {
                                          // Create Firebase auth user
                                          await poststate.auth
                                              .createUserWithEmailAndPassword(
                                            email: authstate
                                                .emailController.text
                                                .trim(),
                                            password: authstate
                                                .passwordController.text
                                                .trim(),
                                          );

                                          final user = UserModel(
                                            companyName: authstate.capitalize(
                                                authstate
                                                    .companyNameController.text
                                                    .trim()),
                                            email: authstate.capitalize(
                                                authstate.emailController.text
                                                    .trim()),
                                            fullName: authstate.capitalize(
                                                authstate
                                                    .fullnameController.text
                                                    .trim()),
                                            password: authstate
                                                .passwordController.text
                                                .trim(),
                                          );

                                          // Add user data to Firestore
                                          final error =
                                              await poststate.createUser(user);

                                          if (error == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Success, your account has been created"),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(error),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DashbaordScreen()),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Registration error: ${e.toString()}"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        } finally {
                                          setState(() {
                                            authstate.isLoading = false;
                                          });
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
                              child: authstate.isLoading
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Sign Up",
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
    });
  }
}
