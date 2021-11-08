import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  final dynamic signUp;
  const Signup({Key? key, @required this.signUp}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _seeFields() {
    print('userName: ${userNameController.text}');
    print('password: ${passwordController.text}');
    print('userName: ${confirmPasswordController.text}');
    print('action signup');
  }

  // void _signUp() async {
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: userNameController.text,
  //       password: passwordController.text,
  //     );
  //     print('saving');
  //   } on FirebaseAuthException catch (err) {
  //     print(err.code);
  //   }
  // }

  // TODO: Make sure the passwords are the same

  @override
  Widget build(BuildContext context) {
    void _signUp() {
      /// I pass context because the [main.dart] function [signUp]
      /// will pop off the sign up page if it executes correctly
      widget.signUp(userNameController.text, passwordController.text, context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          hintText: 'Enter Your Password',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password'),
                    ),
                    ElevatedButton(
                      onPressed: _signUp,
                      child: const Text('Create Account'),
                    ),
                    ////const Expanded(flex: 1, child: Text('')),
                    //// This is just meant to push the text button to the bottom
                    //// const Expanded(child: SizedBox()),
                    //// const SizedBox(
                    ////  height: 20,
                    //// )
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
