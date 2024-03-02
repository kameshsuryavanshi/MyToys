// ignore_for_file: sort_child_properties_last, unused_local_variable, unused_import, unnecessary_import
import 'package:avatar_glow/avatar_glow.dart';
import 'package:mytoys/common/widgets/custom_button.dart';
import 'package:mytoys/common/widgets/custom_textfield.dart';
import 'package:mytoys/features/auth/screens/delayed_animation.dart';
import 'package:mytoys/constants/global_variables.dart';
import 'package:mytoys/features/auth/services/auth_service.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final int delayedAmount = 500;
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      // number: _numberController.text,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const color = Colors.white;
    return Scaffold(
      // backgroundColor: GlobalVariables.greyBackgroundCOlor,

      backgroundColor: const Color(0xFF8185E2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  // height: screenHeight * 0.5,
                  padding: const EdgeInsets.all(4),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        // const SizedBox(height: 5.0),
                        const Text(
                          'Welcome to MyToys',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF8185E2),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Full Name',
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color(0xFF8185E2)),
                            ),
                            onPressed: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                            child: const Text(
                              'Sign Up',
                            ),
                            // style: Colo,
                          ),
                        ),
                        // const SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const Text('Already create account'),
                        //     TextButton(
                        //       onPressed: () {
                        //         _auth == Auth.signup;
                        //       },
                        //       child: const Text('Sign in'),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign-In.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'Welcome back to MyToys',
                          style: TextStyle(
                              color: Color(0xFF8185E2),
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color(0xFF8185E2)),
                            ),
                            onPressed: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                            child: const Text(
                              'LOG IN',
                              selectionColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Forgot password?'),
                          ),
                        ),
                        // const SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const Text('Don\'t have an account? '),
                        //     TextButton(
                        //       onPressed: () {
                        //         _auth == Auth.signup;
                        //       },
                        //       child: const Text('Sign up'),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
