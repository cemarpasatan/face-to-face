import 'package:agora_video_call/pages/HomePage.dart';
import 'package:agora_video_call/pages/auth_screen_view.dart';
import 'package:agora_video_call/pages/login.dart';
import 'package:agora_video_call/provider/profile_provider.dart';
import 'package:agora_video_call/services/authentication_service.dart';
import 'package:agora_video_call/widgets/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            initialData: null,
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges),
        ChangeNotifierProvider(create: (_) => ProfileProvider(),),
      ],
      child: MaterialApp(
        title: 'Agora Group Video Calling',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      //If the user is successfully Logged-In.
      return BottomNavbar(firebaseUser);
    } else {
      //If the user is not Logged-In.
      return AuthScreenView();
    }
  }
}
