import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatapp/service/authentication.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

  void _goToHome() {
    Navigator.pushNamed(context, '/home');
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
      backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () async => Navigator.of(context).pop(),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('About Us',style: GoogleFonts.poppins(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),),
            ],
          ),
        ),
        body:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            'Chat App',
            style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
            'Our mission is to provide high-quality products and services to our customers.',
            style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8),
            Text(
            'Founded in 2015, we have been serving the community for over 10 years. We are proud to have received numerous awards and recognition for our products and customer service.',
            style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8),
            Text(
            'Values:',
            style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
            '- Customer satisfaction is our top priority',
            style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
            '- We strive for continuous improvement',
            style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
            '- We value honesty and integrity in all our actions',
            style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8),
            Text(
            'Awards and Recognition:',
            style: Theme.of(context).textTheme.titleLarge,
            ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Best Product Award, 2012'),
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Customer Service Award, 2014'),
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Innovation Award, 2016'),
              ),
            ],
          ),
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
        selectedItemColor: Colors.amber[800],
        currentIndex: 1,
        onTap: (value) {
          if (value == 0) _goToHome();
          if (value == 3) _goToALogout();
        },
      ),
    );
  }
}