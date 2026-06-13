/*
  Modelo utilizado para armazenar
  informações das promoções exibidas
  no aplicativo.

  Contém título, descrição, imagem
  e identificação da promoção.
*/

class PromoModel {
  final String title;
  final String description;
  final String imagePath;
  final String badge;

  const PromoModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.badge,
  });
}
