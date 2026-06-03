import 'dart:convert';

class AppointmentModel {
  final String service;
  final String barber;
  final String dateIso;
  final String time;
  final String notes;

  const AppointmentModel({
    required this.service,
    required this.barber,
    required this.dateIso,
    required this.time,
    required this.notes,
  });

  DateTime get date => DateTime.parse(dateIso);

  Map<String, dynamic> toMap() {
    return {
      'service': service,
      'barber': barber,
      'dateIso': dateIso,
      'time': time,
      'notes': notes,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      service: map['service'] ?? '',
      barber: map['barber'] ?? '',
      dateIso: map['dateIso'] ?? '',
      time: map['time'] ?? '',
      notes: map['notes'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory AppointmentModel.fromJson(String source) {
    return AppointmentModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
  }
}