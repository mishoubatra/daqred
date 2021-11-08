import 'package:flutter/material.dart';

// * Screens

import 'Auth/login_page.dart';
import 'Auth/signup_page.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
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
  bool _isSignedIn = false;

  // _buildLogin(login) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(primarySwatch: Colors.red),
  //     title: 'Daqred',
  //     home: Login(UniqueKey(), login),
  //     routes: {
  //       '/signup': (context) => const Signup(),
  //     },
  //   );
  // }

  // _buildApp(logout) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(primarySwatch: Colors.red),
  //     title: 'Daqred',
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Logged In!'),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             const Text('You are signed In!'),
  //             ElevatedButton(onPressed: logout, child: const Text('Logout'))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    void _login(String email, String password) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        setState(() {
          _isSignedIn = true;
        });
      } on FirebaseAuthException catch (e) {
        // if (e.code == 'user-not-found') {
        //   print('No user found for that email.');
        // } else if (e.code == 'wrong-password') {
        //   print('Wrong password provided for that user.');
        // }
        print(e.code);
      }
    }

    void _signUp(String email, String password, BuildContext context) async {
      try {
        print('executing');
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        setState(() {
          _isSignedIn = true;
        });
        Navigator.pop(context);
      } on FirebaseAuthException catch (err) {
        print(err.code);
      }
    }

    void _logout() async {
      try {
        await FirebaseAuth.instance.signOut();
        setState(() {
          _isSignedIn = false;
        });
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      title: 'Daqred',
      home: _isSignedIn
          ? Scaffold(
              appBar: AppBar(
                title: const Text('Logged In!'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You are signed In!'),
                    ElevatedButton(
                        onPressed: _logout, child: const Text('Logout'))
                  ],
                ),
              ),
            )
          : Login(login: _login),
      routes: {
        '/signup': (context) => Signup(signUp: _signUp),
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
