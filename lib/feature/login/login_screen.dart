import 'package:flutter/material.dart';
import 'package:flutter_assignment/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(toggleTheme: () {})),
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    if (!value.contains('@')) return 'Please enter valid email';
                    return null;
                  },
                ),
                SizedBox(height: 15),
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
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'This field is Required'
                              : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  child:  Text('Login',style: TextStyle(color: AppPallete.whiteColor,fontWeight: FontWeight.w600),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.gradient3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
