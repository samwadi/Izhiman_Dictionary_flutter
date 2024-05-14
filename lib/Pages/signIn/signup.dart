import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpPage({super.key});

  Future<void> signUpWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('User signed up: ${userCredential.user}');
      // Navigate back to the sign-in page after successful sign-up
      Navigator.pop(context);
    } catch (e) {
      print('Failed to sign up: $e');
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up'),backgroundColor: Colors.amber,),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => signUpWithEmailAndPassword(context),
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20),
          Expanded(
              child: Image.asset("izhiman.png"),
          ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedBackgroundContainer extends StatefulWidget {
  final Widget child;

  const AnimatedBackgroundContainer({super.key, required this.child});

  @override
  _AnimatedBackgroundContainerState createState() =>
      _AnimatedBackgroundContainerState();
}

class _AnimatedBackgroundContainerState
    extends State<AnimatedBackgroundContainer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      vsync: this,
      behaviour: RandomParticleBehaviour(
        options: const ParticleOptions(
          baseColor: Colors.red,
          spawnOpacity: 0.0,
          opacityChangeRate: 0.25,
          minOpacity: 0.1,
          maxOpacity: 0.4,
          particleCount: 70,
          spawnMaxRadius: 15.0,
          spawnMaxSpeed: 100.0,
          spawnMinSpeed: 30,
          spawnMinRadius: 7.0,
        ),
      ),
      child: widget.child,
    );
  }
}
