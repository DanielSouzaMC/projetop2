import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:projetop2/view/items_screen.dart';
import 'package:projetop2/view/register_screen.dart';
import 'package:projetop2/view/reset_password_screen.dart';
import 'package:projetop2/view/auth_screen.dart';
import 'view/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inicializar o Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    debugPrint('Firebase inicializado com sucesso!');
  } catch (e) {
    debugPrint('Erro ao inicializar o Firebase: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: true, 
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: '/telalogin',
        routes: {
          '/telalogin': (context) => const LoginScreen(),
          '/telacadastro': (context) => const RegisterScreen(),
          '/telareset': (context) => const ResetPasswordScreen(),
          '/telamenu': (context) => const ItemsScreen(),
        },
      ),
    );
  }
}
