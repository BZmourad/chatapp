import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatapp/service/authentication.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {





  void _goToHome() {
    Navigator.pushNamed(context, '/home');
  }

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
  Future getDeviceInfo() async {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
  }

  Future getDeviceIp() async {
      return await NetworkInfo().getWifiIP();
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
              Text('Device Info',style: GoogleFonts.poppins(
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
              'Running on ',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
            ' ${getDeviceInfo()}',
            style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            Text(
              'IP ${getDeviceIp()}',
              style: Theme.of(context).textTheme.headlineSmall,
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
        onTap: (value) {
          if (value == 0) _goToHome();
          if (value == 1) _goToAboutUs();
          if (value == 3) _goToALogout();
        },
      ),
    );
  }
}