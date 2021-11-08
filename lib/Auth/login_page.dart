import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  final dynamic login;
  const Login({Key? key, @required this.login}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  // void login(loginState) async {
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: userNameController.text,
  //       password: passwordController.text,
  //     );
  //     loginState();
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    void _login() =>
        widget.login(userNameController.text, passwordController.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200)),
                      height: 150.0,
                      //// width: 190.0,
                      child: Center(
                        child: Image.asset('assets/images/logoplaceholder.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: userNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Enter a valid email',
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter Your Password',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password'),
                    ),
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
                    // !________TEMP BUTTON
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Log Out'),
                    ),
                    // ! ________________
                    ////const Expanded(flex: 1, child: Text('')),
                    // This is just meant to push the text button to the bottom
                    const Expanded(child: SizedBox()),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: const Text('New user? Create an account'),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
