import 'package:flutter/material.dart';
import 'package:inventorymanagement/common/utils/form_validation.dart';
import 'package:inventorymanagement/common/utils/textfield.dart';
import 'package:inventorymanagement/feature/provider/authstate.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _emailSent = false;
  bool _loading = false;

  Future<void> _sendPasswordResetEmail() async {
    setState(() => _loading = true);

    final authProvider = Provider.of<Authstate>(context, listen: false);
    final message =
        await authProvider.sendPasswordResetEmail(_emailController.text);

    if (message == null) {
      setState(() {
        _emailSent = true;
        _emailController.clear();
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Enter your email to receive a password reset link.',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildLabeledField(
                    label: "Email Address",
                    controller: _emailController,
                    validator: CustomValidator.validateEmail,
                    icon: Icons.email,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        _sendPasswordResetEmail();
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _loading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Send Reset Link',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            const SizedBox(height: 20),
            if (_emailSent)
              const Text(
                "Password reset link sent! Redirecting...",
                style: TextStyle(color: Colors.lightGreenAccent),
              ),
          ],
        ),
      ),
    );
  }
}
