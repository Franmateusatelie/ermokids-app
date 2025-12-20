import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetSelectScreen extends StatelessWidget {
  const PetSelectScreen({super.key});

  Future<void> _selectPet(BuildContext context, String pet) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('pet_type', pet);
    await p.setInt('pet_day', 1);
    await p.setString('pet_mood', 'feliz');
    Navigator.pushReplacementNamed(context, '/petHome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(title: const Text('Escolha seu amiguinho')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quem você quer cuidar?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => _selectPet(context, 'dog'),
            child: const Text('🐶 Cachorrinho'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _selectPet(context, 'cat'),
            child: const Text('🐱 Gatinho'),
          ),
        ],
      ),
    );
  }
}

