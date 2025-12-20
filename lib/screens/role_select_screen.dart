import 'package:flutter/material.dart';
import '../core/sound_manager.dart';

class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🌈 FUNDO
          Image.asset(
            'assets/images/background_abc.png',
            fit: BoxFit.cover,
          ),

          // CONTEÚDO
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // 🧸 LOGO TOPO
                    Image.asset(
                      'assets/images/logo_ermokids.png',
                      width: 220,
                    ),

                    const SizedBox(height: 40),

                    // 👶 BOTÃO ÁREA DA CRIANÇA
                    _imageButton(
                      context,
                      image: 'assets/images/btn_crianca.png',
                      onTap: () async {
                        await SoundManager.playClick();
                        Navigator.pushReplacementNamed(context, '/kid');
                      },
                    ),

                    const SizedBox(height: 24),

                    // 👨‍👩‍👧 BOTÃO ÁREA DOS PAIS
                    _imageButton(
                      context,
                      image: 'assets/images/btn_pais.png',
                      onTap: () async {
                        await SoundManager.playClick();
                        Navigator.pushReplacementNamed(context, '/parent');
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageButton(
    BuildContext context, {
    required String image,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        constraints: const BoxConstraints(
          maxWidth: 360,
        ),
        child: Image.asset(
          image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
















