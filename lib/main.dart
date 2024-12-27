import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/signup_screen.dart';
import 'package:chatapp/screens/device_page.dart';
import 'package:chatapp/service/authentication.dart';
import 'package:chatapp/models/chat_screen_argments_model.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:chatapp/screens/about_us_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/chat') {
          final args = settings.arguments as ChatScreenModel;
          return MaterialPageRoute(
            builder: (context) {
              return ChatScreen(
                receiverEmail: args.email,
                receiverUserId: args.userId,
                receiveruserName: args.userName,
              );
            },
          );
        }
        return null;
      },
      routes: {
        '/': (context) => FlutterSplashScreen.fadeIn(
              childWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ChatApp',
                    style: GoogleFonts.poppins(
                      fontSize: 36.0,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              useImmersiveMode: true,
              nextScreen: Authentication.isLoggedIn()
                  ? const HomeScreen()
                  : LoginScreen(),
              backgroundColor: Theme.of(context).primaryColor,
            ),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/device': (context) => DevicePage(),
        '/home': (context) => const HomeScreen(),
        '/about_us': (context) => const AboutUsPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ).copyWith(
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.black,
          onSecondary: Colors.white,
          primaryContainer: Colors.blue,
          onPrimaryContainer: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}
