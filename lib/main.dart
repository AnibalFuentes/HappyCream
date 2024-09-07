import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:happycream/UI/pages/home_page.dart';
import 'package:happycream/UI/pages/login_page.dart';
import 'package:happycream/UI/pages/sign_up_page.dart';
import 'package:happycream/UI/widgets/navigation_bar.dart';
import 'package:happycream/UI/widgets/splash_screen.dart';
import 'package:happycream/controllers/auth_controller.dart';
import 'package:happycream/controllers/topping_controller.dart';

// Controladores que has mencionado anteriormente.

import 'controllers/theme_controller.dart';
import 'controllers/category_controller.dart';
import 'controllers/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialización de Firebase con manejo de errores.
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyAiBpburgDBmiohyuy-TZzK_DBO92xSq-M',
          appId: '1:989118869902:web:91de3de62c9421642034df',
          messagingSenderId: '989118869902',
          projectId: 'happy-cream',
          authDomain: 'happy-cream.firebaseapp.com',
          storageBucket: 'happy-cream.appspot.com',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }

  // Inyección de controladores con GetX.
  Get.put(AuthenticationController());
  Get.put(ThemeController());
  Get.put(CategoryController());
  Get.put(ProductController());
  Get.put(ToppingController());

  runApp(
    DevicePreview(
      enabled:
          !kReleaseMode, // Activa DevicePreview solo en modo de desarrollo.
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtén el controlador de tema para manejar los temas claros y oscuros.
    final ThemeController themeController = Get.find();

    return Obx(() {
      return GetMaterialApp(
        builder: DevicePreview.appBuilder, // Integración con DevicePreview.
        debugShowCheckedModeBanner: false,
        title: 'Happy Cream',
        themeMode: themeController.themeMode.value,
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        locale:
            DevicePreview.locale(context), // Para probar diferentes locales.
        routes: {
          '/': (context) =>
              SplashScreen(child: NavBar()), // Pantalla de inicio.
          '/login': (context) => LoginPage(),
          '/signUp': (context) => const SignUpPage(),
          // Agrega más rutas según tu necesidad.
        },
      );
    });
  }
}
