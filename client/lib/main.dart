import 'package:client/screens/home.dart';
import 'package:client/screens/navigation.dart';
import 'package:client/screens/roam.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart'; // Add this line

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enables it only in debug mode
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathfinder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      useInheritedMediaQuery: true, // Necessary for DevicePreview
      locale: DevicePreview.locale(context), // Adds locale preview
      builder: DevicePreview.appBuilder, // Wraps app with DevicePreview
      home: const SignInScreen(), // Start with Sign In screen
      routes: {
        '/home': (context) => const HomeScreen(),
        '/roam_mode': (context) => const RoamScreen(),
        '/navigation_mode': (context) => Navigation(),
        '/sign_up': (context) => const SignUpScreen(), // Sign Up Route
      },
    );
  }
}

// Sign In Screen
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigate to HomeScreen after Sign In
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate to Sign Up page
                  Navigator.pushNamed(context, '/sign_up');
                },
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sign Up Screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value != password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigate to HomeScreen after Sign Up
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
