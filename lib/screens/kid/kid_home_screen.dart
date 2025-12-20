import 'package:flutter/material.dart';
import '../../core/star_manager.dart';

// Telas
import 'modules/kid_math_screen.dart';
import 'modules/kid_portuguese_screen.dart';
import 'modules/kid_letters_screen.dart';
import 'modules/kid_values_screen.dart';
import '../create/paint_gallery_screen.dart';
import '../music/music_screen.dart';
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
              'assets/images/bg_games.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // 🔝 TOPO COM BOTÃO HOME
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home, size: 30),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/roles');
                        },
                      ),
                      Text(
                        '⭐ $stars',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 🎮 BOTÕES DOS JOGOS
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.all(16),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      _imageButton(
                        image: 'assets/images/btn_pintar.png',
                        onTap: () => _go(context, const PaintGalleryScreen()),
                      ),
                      _imageButton(
                        image: 'assets/images/btn_musica.png',
                        onTap: () => _go(context, const MusicScreen()),
                      ),
                      _imageButton(
                        image: 'assets/images/btn_meu_amiguinho.png',
                        onTap: () => _go(context, const PetSelectScreen()),
                      ),

                      // 👇 Botões simples (podemos trocar depois)
                      _simpleButton(
                        icon: Icons.calculate,
                        label: 'Matemática',
                        onTap: () => _go(context, const KidMathScreen()),
                      ),
                      _simpleButton(
                        icon: Icons.menu_book,
                        label: 'Português',
                        onTap: () => _go(context, const KidPortugueseScreen()),
                      ),
                      _simpleButton(
                        icon: Icons.text_fields,
                        label: 'Completar Palavras',
                        onTap: () => _go(context, const KidLettersScreen()),
                      ),
                      _simpleButton(
                        icon: Icons.eco,
                        label: 'Valores',
                        onTap: () => _go(context, const KidValuesScreen()),
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

  // 🔁 Navegação padrão
  Future<void> _go(BuildContext context, Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
    _loadStars();
  }

  // 🖼 BOTÃO COM IMAGEM
  Widget _imageButton({
    required String image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        image,
        fit: BoxFit.contain,
      ),
    );
  }

  // 🔲 BOTÃO SIMPLES
  Widget _simpleButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
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














