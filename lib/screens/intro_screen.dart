import 'package:flutter/material.dart';
import '../core/app_brand.dart';
import '../services/auth_storage.dart';
import 'auth/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final slides = const [
    _IntroSlide(
      imagePath: 'assets/images/ads/ad1.png',
      badge: 'NOVO',
      title: 'Bem-vindo à Barbearia',
      subtitle: 'Estilo, presença e atendimento premium em cada detalhe.',
      description:
          'Um espaço pensado para quem quer sair com visual marcante e experiência de alto nível.',
      highlights: [
        'Cortes modernos',
        'Ambiente premium',
        'Atendimento rápido',
      ],
    ),
    _IntroSlide(
      imagePath: 'assets/images/ads/ad2.png',
      badge: 'OFERTAS',
      title: 'Promoções exclusivas para você',
      subtitle: 'Acompanhe campanhas especiais e combos promocionais.',
      description:
          'Economize sem abrir mão da qualidade com ofertas criadas para clientes frequentes.',
      highlights: [
        'Descontos semanais',
        'Combos especiais',
        'Vantagens no app',
      ],
    ),
    _IntroSlide(
      imagePath: 'assets/images/ads/ad3.png',
      badge: 'RÁPIDO',
      title: 'Agende em poucos toques',
      subtitle: 'Escolha serviço, horário e barbeiro com total facilidade.',
      description:
          'Tudo foi pensado para você marcar seu horário sem complicação e com mais organização.',
      highlights: [
        'Agenda simples',
        'Escolha de horário',
        'Processo prático',
      ],
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await AuthStorage.setIntroSeen(true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _next() {
    if (_index < slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return;
    }
    _finish();
  }

  void _back() {
    if (_index > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppBrand.appName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Uma experiência mais elegante logo na entrada.',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _index = i),
                itemCount: slides.length,
                itemBuilder: (_, i) {
                  final slide = slides[i];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 5,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  slide.imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.25),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 14,
                                  left: 14,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.55),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      slide.badge,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    slide.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    slide.subtitle,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    slide.description,
                                    style: TextStyle(
                                      color: Colors.grey.shade300,
                                      height: 1.35,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: slide.highlights
                                        .map(
                                          (text) => Chip(
                                            label: Text(text),
                                            side: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.20),
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.10),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  TextButton(
                    onPressed: _back,
                    child: const Text('Voltar'),
                  ),
                  const Spacer(),
                  Row(
                    children: List.generate(
                      slides.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 6),
                        width: _index == i ? 18 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _index == i
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _next,
                    child: Text(
                      _index == slides.length - 1 ? 'Entrar' : 'Próximo',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroSlide {
  final String imagePath;
  final String badge;
  final String title;
  final String subtitle;
  final String description;
  final List<String> highlights;

  const _IntroSlide({
    required this.imagePath,
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.highlights,
  });
}