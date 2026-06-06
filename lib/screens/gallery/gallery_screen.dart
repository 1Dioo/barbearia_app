import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const List<_CutItem> cortes = [
    _CutItem('Social Clássico', 'assets/images/cortes/social.jpg'),
    _CutItem('Buzz Cut', 'assets/images/cortes/buzzcut.jpg'),
    _CutItem('Americano', 'assets/images/cortes/americano.jpg'),
    _CutItem('Low Fade', 'assets/images/cortes/lowfade.jpg'),
    _CutItem('Mid Fade', 'assets/images/cortes/midfade.jpg'),
    _CutItem('High Fade', 'assets/images/cortes/highfade.jpg'),
    _CutItem('Crop Texturizado', 'assets/images/cortes/crop.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Cortes'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: cortes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (_, index) {
          final corte = cortes[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => _ImagePreview(
                    imagePath: corte.imagePath,
                    title: corte.nome,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Theme.of(context).colorScheme.surface,
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    corte.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.black26,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black87,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.zoom_in,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Text(
                      corte.nome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final String imagePath;
  final String title;

  const _ImagePreview({
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.image_not_supported,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }
}

class _CutItem {
  final String nome;
  final String imagePath;

  const _CutItem(this.nome, this.imagePath);
}