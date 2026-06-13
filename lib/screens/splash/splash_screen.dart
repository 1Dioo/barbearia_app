/*
 * Arquivo: splash_screen.dart
 * Responsável pela tela de carregamento inicial do aplicativo.
 * Exibe uma animação simples enquanto o sistema inicia.
 * Após alguns segundos, redireciona o usuário para o EntryGate,
 * que decide qual tela será aberta.
 */

import 'dart:async';
import 'package:flutter/material.dart';
import '../entry_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const EntryGate(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.content_cut,
              size: 80,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
