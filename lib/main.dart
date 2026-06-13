/*
* Arquivo principal da aplicação Royal Barber.
* Responsável por inicializar o Flutter, configurar
* a localização em português (pt-BR) e executar
* o widget principal da aplicação (BarberApp).
*/

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  runApp(const BarberApp());
}
