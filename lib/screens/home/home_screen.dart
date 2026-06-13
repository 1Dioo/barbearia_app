/*
 * Tela inicial do aplicativo.
 * Exibe informações da barbearia, promoções,
 * banner principal e atalhos para outras telas.
 */

import 'package:flutter/material.dart';
import '../../core/app_brand.dart';
import '../../widgets/section_title.dart';
import '../appointments/appointments_screen.dart';
import '../gallery/gallery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gold = Theme.of(context).colorScheme.primary;
    final isCompact = MediaQuery.of(context).size.width < 380;
    final bannerHeight = MediaQuery.of(context).size.width < 600 ? 280.0 : 340.0;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppBrand.appName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppBrand.slogan,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: gold.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.content_cut,
                  color: gold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: bannerHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/banner_home.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.black87,
                      child: const Center(
                        child: Icon(
                          Icons.content_cut,
                          size: 72,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black87,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 18,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Visual premium',
                            style: TextStyle(
                              fontSize: isCompact ? 22 : 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.05,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Cortes modernos, barbeiros experientes e atendimento de alto nível',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              FilledButton.icon(
                                onPressed: () {
                                  _open(context, const AppointmentsScreen());
                                },
                                icon: const Icon(Icons.calendar_month),
                                label: const Text('Agendar agora'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {
                                  _open(context, const GalleryScreen());
                                },
                                icon: const Icon(Icons.photo_library_outlined),
                                label: const Text('Ver galeria'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle(
            title: 'Promoções da Semana',
          ),
          const SizedBox(height: 12),
          _PromoCard(
            title: 'Semana do Corte',
            description:
                'Desconto especial em cortes masculinos de segunda a quinta-feira. Aproveite para renovar o visual gastando menos.',
            badge: 'OFERTA',
          ),
          const SizedBox(height: 14),
          _PromoCard(
            title: 'Combo Barba + Corte',
            description:
                'Visual completo com preço promocional. Ideal para quem busca praticidade e economia.',
            badge: 'PROMO',
          ),
          const SizedBox(height: 28),
          const SectionTitle(
            title: 'Por que escolher nossa barbearia?',
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              children: [
                _FeatureTile(
                  icon: Icons.workspace_premium,
                  title: 'Profissionais Qualificados',
                ),
                Divider(),
                _FeatureTile(
                  icon: Icons.star,
                  title: 'Atendimento Premium',
                ),
                Divider(),
                _FeatureTile(
                  icon: Icons.access_time_filled,
                  title: 'Agendamento Rápido',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final String title;
  final String description;
  final String badge;

  const _PromoCard({
    required this.title,
    required this.description,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final gold = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureTile({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
