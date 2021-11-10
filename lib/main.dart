// Essential Packages
import 'package:flutter/material.dart';
// * Screens

import 'Auth/login_page.dart';
import 'Auth/signup_page.dart';
import 'home_page.dart' show Homepage;

/// import[Firebase] | this is Database
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Root
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  /// Initialize [Firebase]
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Loading();
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
////  bool _isSignedIn = false;

  // Handles the state change for when the user logs in or out and notifying the backend
  @override
  Widget build(BuildContext context) {
    // Handles all login logic
    void login(String email, String password, BuildContext context) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Executes only when the backend accepts request
        // Once logged in through backend navigate to the home page
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    }

    // Handles all sign up logic
    void signUp(String email, String password, BuildContext context) async {
      try {
        print('executing');
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Executes only when the backend accepts request
        // Once signed up through backend navigate to the home page
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (err) {
        print(err.code);
      }
    }

    // Handles all logout logic
    void logout(BuildContext context) async {
      try {
        await FirebaseAuth.instance.signOut();
        // Executes only when the backend accepts request
        // Once logged out through backend navigate to the login page
        Navigator.pushReplacementNamed(context, '/login');
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      title: 'Daqred',
      // ! Later add logic for automatic sign in because right now the app will
      // ! always go to the login page initially
      home: Login(
        login: login,
      ),
      // ? the routes of our application
      routes: {
        '/login': (context) => Login(login: login),
        '/signup': (context) => Signup(signUp: signUp),
        '/home': (context) => Homepage(logout: logout)
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daqred',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Daqred'),
        ),
        body: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daqred',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Daqred'),
        ),
        body: const Center(
          child: Text('SomethingWentWrong'),
        ),
      ),
    );
  }
}
