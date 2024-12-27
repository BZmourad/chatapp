import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/models/chat_screen_argments_model.dart';
import 'package:chatapp/service/authentication.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _goToAboutUs() {
    Navigator.pushNamed(context, '/about_us');
  }

  void _goToALogout() async {
    await Authentication.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () async {
              Navigator.pushNamed(context, '/about_us');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () async {
              await Authentication.signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Chat App',
              style: GoogleFonts.poppins(
                fontSize: 24.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .where((doc) =>
                    doc['email'] != FirebaseAuth.instance.currentUser!.email)
                .map<Widget>((doc) => ListTile(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: ChatScreenModel(
                          userId: doc['uid'],
                          email: doc['email'],
                          userName: doc['email'].toString().split('@')[0],
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: Text(doc['email'][0].toString().toUpperCase() +
                            doc['email']
                                .toString()
                                .split('@')[1][0]
                                .toUpperCase()),
                      ),
                      title: Text(
                        doc['email'].toString().split('@')[0][0].toUpperCase() +
                            doc['email']
                                .toString()
                                .split('@')[0]
                                .substring(1)
                                .toLowerCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        doc['email'],
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ))
                .toList(),
          );
        },
      ),
      drawer: Drawer(
          child: ListView(
            // Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                title: const Text('About us'),
                onTap: () {
                  Navigator.pushNamed(context, '/about_us');
                },
              ),
            ],
          )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: 'Info',
        onPressed: (){
          Navigator.pushNamed(context, '/device');
        },
        child: const Icon(Icons.question_mark_outlined, color: Colors.white, size: 50),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          if (value == 1) _goToAboutUs();
          if (value == 3) _goToALogout();
        },
      ),
    );
  }
}
