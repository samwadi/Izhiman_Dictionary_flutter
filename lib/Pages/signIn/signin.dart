import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Home/add_word.dart';
import './signup.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInPage({super.key});

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('User signed in: ${userCredential.user}');
      // Navigate to the main page after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Sign In')),
      );
    } catch (e) {
      print('Failed to sign in: $e');
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 250, 228, 98),
      appBar: AppBar(
        title: const Text('Izhiman Dictionary'),
        backgroundColor: Colors.redAccent,
      ),
      body: AnimatedBackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded( // Wrap the button with Expanded
                    child: ElevatedButton(
                      onPressed: () => signInWithEmailAndPassword(context),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.greenAccent,
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded( // Wrap the button with Expanded
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                SignUpPage()),
                          ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow,
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded( // Wrap the Image.asset with Expanded
                child: Image.asset("izhiman.png", width: 500, height: 500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}