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
          // 🔹 FUNDO
          Image.asset(
            'assets/images/bg_abc.png', // imagem de fundo
            fit: BoxFit.cover,
          ),

          // 🔹 CONTEÚDO CENTRAL
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // 🔹 LOGO NO TOPO
                Image.asset(
                  'assets/images/logo_ermokids.png',
                  height: 110,
                ),

                const Spacer(),

                // 🔹 BOTÃO ÁREA DA CRIANÇA
                _imageButton(
                  context,
                  image: 'assets/images/btn_area_crianca.png',
                  onTap: () async {
                    await SoundManager.playClick();
                    Navigator.pushReplacementNamed(context, '/kid');
                  },
                ),

                const SizedBox(height: 24),

                // 🔹 BOTÃO ÁREA DOS PAIS
                _imageButton(
                  context,
                  image: 'assets/images/btn_area_pais.png',
                  onTap: () async {
                    await SoundManager.playClick();
                    Navigator.pushReplacementNamed(context, '/parent');
                  },
                ),

                const Spacer(flex: 2),
              ],
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
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Image.asset(
          image,
          width: MediaQuery.of(context).size.width * 0.78,
        ),
      ),
    );
  }
}











