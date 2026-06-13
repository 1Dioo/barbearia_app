/*
 * Arquivo: main_shell.dart
 * Responsável pela navegação principal do aplicativo.
 * Controla as telas exibidas através da NavigationBar.
 * Mantém o estado das páginas utilizando IndexedStack.
 * Centraliza o acesso às seções:
 * Início, Agenda, Clube, Ofertas e Perfil.
 */

import 'package:flutter/material.dart';
import 'appointments/appointments_screen.dart';
import 'club/club_screen.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';
import 'promotions/promotions_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final pages = const [
    HomeScreen(),
    AppointmentsScreen(),
    ClubScreen(),
    PromotionsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_available_outlined),
            label: 'Agenda',
          ),
          NavigationDestination(
            icon: Icon(Icons.workspace_premium_outlined),
            label: 'Clube',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_offer_outlined),
            label: 'Ofertas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
