import 'package:flutter/material.dart';

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            'Promoções',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const SizedBox(height: 8),

          Text(
            'Confira nossas ofertas especiais e campanhas da semana.',
            style: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/promos/banner_top.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  height: 180,
                  color: Colors.black54,
                  child: const Center(
                    child: Text(
                      'Banner Superior',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 22),

          _PromoCard(
            title: 'Semana do Corte',
            description:
                'Desconto especial em cortes masculinos de segunda a quinta-feira.',
            badge: 'OFERTA',
          ),

          const SizedBox(height: 14),

          _PromoCard(
            title: 'Combo Barba + Corte',
            description:
                'Visual completo com preço promocional e atendimento premium.',
            badge: 'PROMO',
          ),

          const SizedBox(height: 14),

          _PromoCard(
            title: 'Cliente Fidelidade',
            description:
                'Clientes frequentes recebem descontos e benefícios exclusivos.',
            badge: 'VIP',
          ),

          const SizedBox(height: 22),

          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/promos/banner_bottom.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  height: 180,
                  color: Colors.black54,
                  child: const Center(
                    child: Text(
                      'Banner Inferior',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
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