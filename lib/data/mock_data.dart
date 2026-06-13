/*
  Classe responsável por armazenar
  dados fictícios utilizados durante
  o desenvolvimento e testes do sistema.

  Contém listas de serviços e promoções
  exibidas no aplicativo.
*/

import '../models/service_model.dart';
import '../models/promo_model.dart';

class MockData {
  static const services = <ServiceModel>[
    ServiceModel(
      title: 'Corte Degradê',
      subtitle: 'Acabamento limpo e moderno',
      price: 45.0,
      imagePath: 'assets/images/cortes/corte1.jpg',
      duration: Duration(minutes: 40),
    ),
    ServiceModel(
      title: 'Barba Completa',
      subtitle: 'Navalha, toalha quente e finalização',
      price: 35.0,
      imagePath: 'assets/images/cortes/corte2.jpg',
      duration: Duration(minutes: 30),
    ),
    ServiceModel(
      title: 'Combo Premium',
      subtitle: 'Corte + barba + acabamento',
      price: 70.0,
      imagePath: 'assets/images/cortes/corte3.jpg',
      duration: Duration(minutes: 60),
    ),
  ];

  static const promos = <PromoModel>[
    PromoModel(
      title: 'Semana do Corte',
      description: 'Desconto especial no corte masculino de segunda a quinta',
      imagePath: 'assets/images/promos/promo1.jpg',
      badge: 'OFERTA',
    ),
    PromoModel(
      title: 'Combo Barba + Corte',
      description: 'Visual completo com preço promocional',
      imagePath: 'assets/images/promos/promo2.jpg',
      badge: 'PROMO',
    ),
  ];
}
