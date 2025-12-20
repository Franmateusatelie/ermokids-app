import 'package:flutter/material.dart';

// telas já existentes
import 'screens/splash_screen.dart';
import 'screens/role_select_screen.dart';
import 'screens/kid/kid_home_screen.dart';
import 'screens/parent/parent_home_screen.dart';

// 🐶 novas telas do pet
import 'screens/pet/pet_select_screen.dart';
import 'screens/pet/pet_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ErmoKidsApp());
}

class ErmoKidsApp extends StatelessWidget {
  const ErmoKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ErmoKids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),

      // 🔹 AQUI FICAM AS ROTAS 🔹
      routes: {
        '/': (_) => const SplashScreen(),
        '/roles': (_) => const RoleSelectScreen(),
        '/kid': (_) => const KidHomeScreen(),
        '/parent': (_) => const ParentHomeScreen(),

        // 🐾 PET VIRTUAL
        '/petSelect': (_) => const PetSelectScreen(),
        '/petHome': (_) => const PetHomeScreen(),
      },
    );
  }
}

