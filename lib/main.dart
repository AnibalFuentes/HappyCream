import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:happycream/UI/pages/login_page.dart';
import 'package:happycream/UI/pages/presentation_page.dart';
import 'package:happycream/UI/pages/sign_up_page.dart';
import 'package:happycream/UI/widgets/splash_screen.dart';
import 'package:happycream/controllers/auth_controller.dart';



//importaciones firebase

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyAiBpburgDBmiohyuy-TZzK_DBO92xSq-M',
    appId: '1:989118869902:web:91de3de62c9421642034df',
    messagingSenderId: '989118869902',
    projectId: 'happy-cream',
    authDomain: 'happy-cream.firebaseapp.com',
    storageBucket: 'happy-cream.appspot.com',
            ));
  }
  await Firebase.initializeApp().then((value) {
    Get.put(AuthenticationController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moo App',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      routes: {
        '/': (context) => const SplashScreen(
              child: LoginPage(),
            ),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        /*'/home': (context) => const NavBar(),
        '/batch': (context) => const BatchPage(),*/
      },
    );
  }
}
