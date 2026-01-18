import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jublicare/bloc/login/login_bloc.dart';
import 'package:jublicare/bloc/login/login_event.dart';
import 'package:jublicare/bloc/login/login_state.dart';
import 'package:jublicare/common/app_colors.dart';
import '../HomeScreen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          }
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                // Top-left half-circle
                Positioned(
                  top: -100, // move it up so only half shows
                  right: 90,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Top-right half-circle
                Positioned(
                  top: -100,
                  right: -70,
                  child: Container(
                    width: 270,
                    height: 380 ,
                    decoration: BoxDecoration(
                      color: AppColors.bg1,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Column with images and login form
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // First Image
                        Image.asset(
                          'assets/img/jubicare.webp',
                          height: 160,
                        ),
                        const SizedBox(width: 16),
                        // Second Image
                        Image.asset(
                          'assets/img/logo.png',
                          height: 150,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Login Form
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Username TextField
                              TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                    labelText: "Enter Username",
                                    labelStyle: const TextStyle(fontSize: 14),
                                    suffixIcon: const Icon(Icons.person,
                                        color: AppColors.primary),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: AppColors.primary, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                    )),
                              ),
                              const SizedBox(height: 16),

                              // Password TextField
                              TextField(
                                controller: passwordController,
                                obscureText: !showPassword,
                                decoration: InputDecoration(
                                    labelText: "Enter Password",
                                    labelStyle: const TextStyle(fontSize: 14),
                                    suffixIcon: const Icon(Icons.lock_open_sharp,
                                        color: AppColors.primary),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: AppColors.primary, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1))),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Checkbox(
                                      value: showPassword,
                                      onChanged: (val) {
                                        setState(() {
                                          showPassword = val ?? false;
                                        });
                                      }),
                                  const Text("Show Password"),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Sign In Button / Loading
                              SizedBox(
                                width: double.infinity,
                                child: state is LoginLoading
                                    ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                    : ElevatedButton(
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                      LoginSubmitted(
                                        username: usernameController.text
                                            .trim(),
                                        password: passwordController.text
                                            .trim(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8)),
                                    elevation: 5,
                                    minimumSize:
                                    const Size(double.infinity, 50),
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Sign Up Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to sign up
                                    },
                                    child: const Text(
                                      "Sign up",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
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
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
