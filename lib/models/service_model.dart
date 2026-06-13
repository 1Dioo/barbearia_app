/*
  Modelo que representa um serviço
  oferecido pela barbearia.

  Armazena nome, descrição, preço,
  imagem ilustrativa e duração
  estimada do atendimento.
*/

class ServiceModel {
  final String title;
  final String subtitle;
  final double price;
  final String imagePath;
  final Duration duration;

  const ServiceModel({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
    required this.duration,
  });
}
