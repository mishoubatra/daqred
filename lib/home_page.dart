import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key, @required this.logout}) : super(key: key);

  final dynamic logout;

  @override
  Widget build(BuildContext context) {
    void _logout() => logout(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged In!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You are signed In!'),
            ElevatedButton(onPressed: _logout, child: const Text('Logout New'))
          ],
        ),
      ),
    );
  }
}
