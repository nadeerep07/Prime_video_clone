import 'package:amazon_prime_clone/screens/password_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _inputController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = true; // Added loading state

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PasswordScreen()),
      );
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogin() async {
    if (_inputController.text.trim() == 'test@example.com') {
      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isEmailEntered', true);
      await prefs.setString('userEmail', _inputController.text.trim());

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PasswordScreen()),
        );
      }
    } else {
      setState(() {
        _errorMessage = "Incorrect input. Please try again.";
      });
      Future.delayed(Duration(seconds: 3), () {
        if (mounted) setState(() => _errorMessage = null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading screen while checking login status
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F171E),
        body: Center(child: CircularProgressIndicator(color: Colors.blue)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F171E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/amazon_logo.png', height: 50),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // Handle refresh action
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            if (_errorMessage != null)
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            SizedBox(height: 20),
            Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Sign in Already a customer?",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            const Text(
              "Email or phone number",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 111, 208),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text("Continue", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                style: TextStyle(color: Colors.grey[400]),
                children: [
                  TextSpan(text: "By signing in, you agree to the "),
                  TextSpan(
                    text: "Prime Video Terms of Use",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  TextSpan(
                    text:
                        " and license agreements which can be found on the Amazon website.",
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Prime membership is required to watch Prime-eligible titles.\n",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextSpan(
                    text: "Need help?",
                    style: TextStyle(color: Colors.lightBlueAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "© 1996–2025, Amazon.com, Inc. or its affiliates",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
