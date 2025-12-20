import 'package:flutter/material.dart';
import 'kids_menu_screen.dart';
import 'parents_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TOPO - LOGO
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 90,
                    ),
                  ),
                ),

                // CENTRO - BOTÕES
                Column(
                  children: [
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

                    const SizedBox(height: 24),

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
                  ],
                ),

                // RODAPÉ
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Ermotech Solutions TI 2025',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


