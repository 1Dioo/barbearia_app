/*
 * Widget utilizado para apresentar serviços oferecidos
 * pela barbearia.
 *
 * Exibe imagem, nome, descrição, preço e duração
 * utilizando dados provenientes do ServiceModel.
 */

import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceCard({super.key,required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color:  Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusGeometry.vertical(top: Radius.circular(22)),
            child: Image.asset(
              service.imagePath,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 130,
                color: Colors.black26,
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.title,
                    style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(
                  service.subtitle,
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'R\$ ${service.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${service.duration.inMinutes} min',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
