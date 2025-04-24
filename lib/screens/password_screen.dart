import 'package:amazon_prime_clone/screens/login_screen.dart';
import 'package:amazon_prime_clone/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _inputController = TextEditingController();
  String? _errorMessage;
  bool isLoading = true;
  bool _isPasswordVisible = false;

  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadEmail();
    _checkLoginStatus();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('userEmail') ?? '';
    });
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isEmailEntered = prefs.getBool('isEmailEntered') ?? false;
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isEmailEntered && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else if (isLoggedIn && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
        (route) => false,
      );
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> _handleLogin() async {
    if (_inputController.text.trim() == '12345') {
      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
          (route) => false,
        );
      }
    } else {
      setState(() {
        _errorMessage = "Incorrect Password. Please try again.";
      });
      Future.delayed(Duration(seconds: 3), () {
        if (mounted) setState(() => _errorMessage = null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              'Sign in',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text.rich(
              TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(text: "@$_email "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        // Clear login state to allow changing email
                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setBool('isEmailEntered', false);
                          prefs.remove('userEmail');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        });
                      },
                      child: Text(
                        "change",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            const Text(
              "Amazon password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_isPasswordVisible,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Add this wrapper
                  child: CheckboxListTile(
                    value: _isPasswordVisible,
                    onChanged: (bool? value) {
                      setState(() {
                        _isPasswordVisible = value ?? false;
                      });
                    },
                    title: Text(
                      "Show password",
                      style: TextStyle(color: Colors.white),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.white,
                    checkColor: Colors.orangeAccent,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    // Handle help action
                  },
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 111, 208),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text("sign in", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 80),
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
