import 'package:flutter/material.dart';

// Telas principais
import 'screens/splash_screen.dart';
import 'screens/role_select_screen.dart';
import 'screens/kid/kid_home_screen.dart';
import 'screens/parent/parent_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ErmoKidsApp());
}

class ErmoKidsApp extends StatelessWidget {
  const ErmoKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ErmoKids',

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),

      // 🔴 ESSENCIAL — NÃO REMOVER
      initialRoute: '/',

      routes: {
        '/': (_) => const SplashScreen(),

        // 👇 ESTA TELA É A DOS BOTÕES
        // Área da Criança / Área dos Pais
        '/roles': (_) => const RoleSelectScreen(),

        // Áreas internas
        '/kid': (_) => const KidHomeScreen(),
        '/parent': (_) => const ParentHomeScreen(),
      },
    );
  }
}


