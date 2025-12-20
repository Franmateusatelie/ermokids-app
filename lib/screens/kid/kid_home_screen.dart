import 'package:flutter/material.dart';
import '../../core/star_manager.dart';

import '../music/music_screen.dart';
import '../create/paint_screen.dart';
import 'modules/kid_math_screen.dart';
import 'modules/kid_portuguese_screen.dart';
import 'modules/kid_dino_egg_screen.dart';
import 'modules/kid_letters_screen.dart';
import 'modules/kid_values_screen.dart';

class KidHomeScreen extends StatefulWidget {
  const KidHomeScreen({super.key});

  @override
  State<KidHomeScreen> createState() => _KidHomeScreenState();
}

class _KidHomeScreenState extends State<KidHomeScreen> {
  int stars = 0;

  @override
  void initState() {
    super.initState();
    _loadStars();
  }

  Future<void> _loadStars() async {
    stars = await StarManager.getStars();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('ErmoKids 🎈'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '⭐ $stars',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        children: [
          _btn(context, Icons.calculate, 'Matemática',
              const KidMathScreen()),
          _btn(context, Icons.menu_book, 'Português',
              const KidPortugueseScreen()),
          _btn(context, Icons.text_fields, 'Completar Palavras',
              const KidLettersScreen()),
          _btn(context, Icons.eco, 'Valores',
              const KidValuesScreen()),
          _btn(context, Icons.palette, 'Pintar',
              const PaintScreen()),
          _btn(context, Icons.egg_alt, 'Ovinho do Dino',
              const KidDinoEggScreen()),
          _btn(context, Icons.music_note, 'Músicas',
              const MusicScreen()),
        ],
      ),
    );
  }

  Widget _btn(BuildContext context, IconData icon, String label, Widget page) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
          _loadStars(); // atualiza ao voltar
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 46, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}








