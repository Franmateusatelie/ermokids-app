import 'package:flutter/material.dart';
import '../../core/star_manager.dart';

// Telas
import '../music/music_screen.dart';
import '../create/paint_gallery_screen.dart';
import 'modules/kid_math_screen.dart';
import 'modules/kid_portuguese_screen.dart';
import 'modules/kid_letters_screen.dart';
import 'modules/kid_values_screen.dart';

// Pet
import '../pet/pet_select_screen.dart';

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
      body: Stack(
        children: [
          // 🌈 FUNDO
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_kids.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // 🔝 TOPO COM BOTÃO HOME E ESTRELAS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 🏠 BOTÃO HOME
                      IconButton(
                        icon: const Icon(Icons.home, size: 32),
                        color: Colors.deepPurple,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/roles');
                        },
                      ),

                      // ⭐ ESTRELAS
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '⭐ $stars',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 🎮 BOTÕES DOS JOGOS
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _gameBtn(context, Icons.calculate, 'Matemática', const KidMathScreen()),
                      _gameBtn(context, Icons.menu_book, 'Português', const KidPortugueseScreen()),
                      _gameBtn(context, Icons.text_fields, 'Completar Palavras', const KidLettersScreen()),
                      _gameBtn(context, Icons.eco, 'Valores', const KidValuesScreen()),
                      _gameBtn(context, Icons.palette, 'Pintar 🎨', const PaintGalleryScreen()),
                      _gameBtn(context, Icons.music_note, 'Músicas 🎵', const MusicScreen()),

                      // 🐾 BOTÃO COM IMAGEM – MEU AMIGUINHO
                      _imageBtn(
                        context,
                        'assets/images/btn_pet.png',
                        'Meu Amiguinho',
                        const PetSelectScreen(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔘 BOTÃO PADRÃO
  Widget _gameBtn(BuildContext context, IconData icon, String label, Widget page) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        _loadStars();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 46, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // 🖼 BOTÃO COM IMAGEM (PET)
  Widget _imageBtn(BuildContext context, String image, String label, Widget page) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        _loadStars();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4)),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 90, fit: BoxFit.contain),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}












