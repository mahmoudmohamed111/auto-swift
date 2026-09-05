import 'package:auto_swift/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:auto_swift/core/components/custom_button.dart';
import 'package:auto_swift/core/components/custom_text_field.dart';
import 'package:auto_swift/core/components/snack.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isSignUp = false;
  bool isLoading = false;

  final supabase = Supabase.instance.client;

  Future<void> handleAuth() async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() => isLoading = true);

    try {
      if (isSignUp) {
        final AuthResponse res = await supabase.auth.signUp(
          email: email,
          password: password,
        );

        if (mounted) {
          if (res.session == null) {
            Snack().success(
              context,
              "Sign up successful! Please check your email for confirmation.",
            );
          } else {
            Snack().success(context, "Account created & logged in!");
          }
        }
      } else {
        await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );

        if (mounted) {
          Snack().success(context, "Logged in successfully!");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        }
      }
    } on AuthException catch (e) {
      if (mounted) {
        Snack().error(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        Snack().error(context, "An unexpected error occurred: $e");
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.directions_car_rounded,
                  size: 80,
                  color: Colors.black,
                ),
                const SizedBox(height: 16),
                Text(
                  isSignUp ? "Create Account" : "Welcome Back",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isSignUp
                      ? "Sign up to get started with Auto Swift"
                      : "Sign in to continue to Auto Swift",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 32),

                // Email Field
                CustomTextField(
                  controller: emailController,
                  hint: "Email Address",
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: passwordController,
                  hint: "Password",
                  type: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 24),

                CustomButton(
                  width: double.infinity,
                  height: 48,
                  color: Colors.black,
                  radius: 24,
                  onTap: isLoading ? null : handleAuth,
                  child: Center(
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            isSignUp ? "Sign Up" : "Sign In",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isSignUp
                          ? "Already have an account? "
                          : "Don't have an account? ",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSignUp = !isSignUp;
                        });
                      },
                      child: Text(
                        isSignUp ? "Sign In" : "Sign Up",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
