import 'package:flutter/material.dart';
import 'package:flutter_assignment/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/global.dart';
import '../../core/theme/app_pallete.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      setState(() => _isLoading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border([Color color = AppPallete.borderColor]) =>
        OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 3),
          borderRadius: BorderRadius.circular(10),
        );
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Log In",
                    style: TextStyle(
                      color: AppPallete.gradient3,
                      fontSize: mq.width * .15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: mq.height * .03),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: border(),
                      focusedBorder: border(AppPallete.gradient2),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'This field is Required';
                      if (!value.contains('@gmail.com'))
                        return 'Please enter valid email';
                      return null;
                    },
                  ),
                  SizedBox(height: mq.height * .015),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: border(),
                      focusedBorder: border(AppPallete.gradient2),
                      suffixIconColor: AppPallete.gradient2,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is Required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                        return 'Password must contain at least one letter';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: mq.height * .050),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient:
                          _isLoading
                              ? LinearGradient(
                                colors: [
                                  AppPallete.lightGradient3,
                                  AppPallete.lightGradient2,
                                ],
                              )
                              : const LinearGradient(
                                colors: [
                                  AppPallete.gradient3,
                                  AppPallete.gradient2,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(395, 55),
                        backgroundColor: AppPallete.transparentColor,
                        shadowColor: AppPallete.transparentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          _isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                              : Text(
                                "Log in",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppPallete.whiteColor,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
