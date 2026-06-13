/*
  Modelo responsável por representar
  um agendamento realizado pelo usuário.

  Armazena informações do serviço,
  barbeiro escolhido, data, horário,
  observações, forma de pagamento e valor.

  Possui métodos para conversão entre
  objeto, Map e JSON.
*/

import 'dart:convert';

double _parseDouble(dynamic value) {
  if (value is num) return value.toDouble();
  if (value is String) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  }
  return 0.0;
}

class AppointmentModel {
  final String service;
  final String barber;
  final String dateIso;
  final String time;
  final String notes;
  final String paymentMethod;
  final double price;

  const AppointmentModel({
    required this.service,
    required this.barber,
    required this.dateIso,
    required this.time,
    required this.notes,
    this.paymentMethod = 'Não informado',
    this.price = 0.0,
  });

  DateTime get date => DateTime.parse(dateIso);

  Map<String, dynamic> toMap() {
    return {
      'service': service,
      'barber': barber,
      'dateIso': dateIso,
      'time': time,
      'notes': notes,
      'paymentMethod': paymentMethod,
      'price': price,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      service: map['service'] ?? '',
      barber: map['barber'] ?? '',
      dateIso: map['dateIso'] ?? '',
      time: map['time'] ?? '',
      notes: map['notes'] ?? '',
      paymentMethod: map['paymentMethod'] ?? 'Não informado',
      price: _parseDouble(map['price']),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory AppointmentModel.fromJson(String source) {
    return AppointmentModel.fromMap(
      jsonDecode(source) as Map<String, dynamic>,
    );
  }
}
