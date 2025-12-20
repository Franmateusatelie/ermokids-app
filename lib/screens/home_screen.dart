import 'package:flutter/material.dart';
import 'kids_menu_screen.dart';
import 'parents_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FUNDO
          Positioned.fill(
            child: Image.asset(
              'assets/images/abc123.png',
              fit: BoxFit.cover,
            ),
          ),

          // CONTEÚDO
          Column(
            children: [
              const SizedBox(height: 40),

              // LOGO TOPO
              Image.asset(
                'assets/images/logo.png',
                width: 90, // 🔥 TAMANHO PEQUENO COMO PEDIU
              ),

              const Spacer(),

              // BOTÃO ÁREA DA CRIANÇA
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const KidsMenuScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/btn_crianca.png',
                  width: 260,
                ),
              ),

              const SizedBox(height: 20),

              // BOTÃO ÁREA DOS PAIS
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ParentsScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/btn_pais.png',
                  width: 260,
                ),
              ),

              const Spacer(),

              // RODAPÉ
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'Ermotech Solutions TI 2025',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

