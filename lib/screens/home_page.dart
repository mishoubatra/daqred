import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'you.dart';

// Piece of Data, just a database test
class Pod {
  Pod({required this.title, required this.id});
  final String title;
  final int id;

  Pod.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          id: json['id']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'id': id,
    };
  }
}

final podsRef =
    FirebaseFirestore.instance.collection('pods').withConverter<Pod>(
          fromFirestore: (snapshot, _) => Pod.fromJson(snapshot.data()!),
          toFirestore: (pod, _) => pod.toJson(),
        );

class Homepage extends StatefulWidget {
  const Homepage({Key? key, @required this.logout}) : super(key: key);
  final dynamic logout;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // * State
  int _selectedIndex = 0;

  final List<Widget> _widgetPages = [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You are signed In!'),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Test Database'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Logout'),
          )
        ],
      ),
    ),
    const YouScreen(),
    const Center(
      child: Text('settings'),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _logout() => widget.logout(context);

    Future<void> _testDb() async {
      await podsRef.add(
        Pod(id: 777, title: "Hello World"),
      );
      print('Writing to DB Firestore');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged In!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.qr_code),
      ),
      body: _widgetPages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: 'You',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
