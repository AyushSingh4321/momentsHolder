import 'package:assignment2/main.dart';
import 'package:flutter/material.dart';
import 'package:assignment2/Authentication/auth_service.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _isLoading = false; // Loading state

  void _handleSignIn() async {
    setState(() {
      _isLoading = true; // Show spinner
    });

    try {
      final user = await AuthService().signInWithGoogle();
      if (user != null) {
        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Tabs(), // Replace with your home screen
          ),
        );
      } else {
        // If user cancels the sign-in
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign-in was canceled")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide spinner
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Loading spinner
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50), // Add some top padding
                  const Center(
                    child: Text(
                      'WELCOME!',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 50),
                    ),
                  ),
                  const SizedBox(
                      height: 80), // Add spacing between text and button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        backgroundColor:
                            Colors.white, // Button background color
                      ),
                      onPressed: _handleSignIn,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(
                              width: 10), // Spacing between image and text
                          const Text(
                            'Sign-in with Google',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black, // Text color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
