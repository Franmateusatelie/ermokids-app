import 'package:flutter/material.dart';
import '../../core/star_manager.dart';

// Telas
import '../music/music_screen.dart';
import '../create/paint_gallery_screen.dart';
import 'modules/kid_math_screen.dart';
import 'modules/kid_portuguese_screen.dart';
import 'modules/kid_letters_screen.dart';
import 'modules/kid_values_screen.dart';

// (Pet virtual entra aqui depois)
// import '../pet/pet_select_screen.dart';

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
        centerTitle: true,
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
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _btn(
            context,
            Icons.calculate,
            'Matemática',
            const KidMathScreen(),
          ),
          _btn(
            context,
            Icons.menu_book,
            'Português',
            const KidPortugueseScreen(),
          ),
          _btn(
            context,
            Icons.text_fields,
            'Completar Palavras',
            const KidLettersScreen(),
          ),
          _btn(
            context,
            Icons.eco,
            'Valores',
            const KidValuesScreen(),
          ),
          _btn(
            context,
            Icons.palette,
            'Pintar 🎨',
            const PaintGalleryScreen(),
          ),
          _btn(
            context,
            Icons.music_note,
            'Músicas 🎵',
            const MusicScreen(),
          ),

          // 🔜 Aqui entra o Pet Virtual (gatinho/cachorrinho)
          // _btn(context, Icons.pets, 'Meu Amiguinho', const PetSelectScreen()),
        ],
      ),
    );
  }

  Widget _btn(
    BuildContext context,
    IconData icon,
    String label,
    Widget page,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
          _loadStars(); // atualiza estrelas ao voltar
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.deepPurple),
            const SizedBox(height: 12),
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









