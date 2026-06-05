import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  final List<Map<String, String>> cortes = const [
    {
      'nome': 'Social Clássico',
      'imagem': 'assets/images/cortes/social.jpg',
    },
    {
      'nome': 'Buzz Cut',
      'imagem': 'assets/images/cortes/buzzcut.jpg',
    },
    {
      'nome': 'Americano',
      'imagem': 'assets/images/cortes/americano.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Cortes'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cortes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, index) {
          final corte = cortes[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  corte['imagem']!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.black26,
                    child: const Center(
                      child: Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(8),
                  color: Colors.black54,
                  child: Text(
                    corte['nome']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}