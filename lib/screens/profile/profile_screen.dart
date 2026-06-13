/*
 * Arquivo: profile_screen.dart
 * Responsável pelo gerenciamento do perfil do usuário.
 * Permite visualizar e editar informações pessoais,
 * alterar foto de perfil, visualizar dados da assinatura
 * e realizar logout da conta.
 * Também exibe estatísticas e informações da conta.
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_brand.dart';
import '../../models/app_user.dart';
import '../../services/auth_storage.dart';
import '../../services/subscription_storage.dart';
import '../../widgets/primary_action_button.dart';
import '../../widgets/stat_card.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppUser? user;
  bool loading = true;

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    user = await AuthStorage.getCurrentUser();

    nameCtrl.text = user?.name ?? '';
    phoneCtrl.text = user?.phone ?? '';

    setState(() {
      loading = false;
    });
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();

    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (file == null) return;

    final bytes = await file.readAsBytes();
    final base64Image = base64Encode(bytes);

    await AuthStorage.updateAvatar(base64Image);
    await _load();
  }

  Future<void> _editProfile() async {
    await AuthStorage.updateProfile(
      name: nameCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
    );

    await _load();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil atualizado com sucesso!'),
      ),
    );
  }

  Future<void> _logout() async {
    await AuthStorage.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final avatar = user?.avatarBase64;

    final image = avatar != null
        ? MemoryImage(base64Decode(avatar))
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context)
                      .colorScheme
                      .surface
                      .withOpacity(0.75),
                ],
              ),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.15),
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickPhoto,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.25),
                              blurRadius: 25,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.shade800,
                          backgroundImage: image,
                          child: image == null
                              ? const Icon(
                                  Icons.person,
                                  size: 55,
                                )
                              : null,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  user?.name ?? 'Usuário',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 4),

                Text(
                  user?.email ?? '',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  user?.phone ?? '',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Toque na foto para alterar',
                  style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 18),

                FutureBuilder<String?>(
                  future:
                      SubscriptionStorage.getCurrentPlan(),
                  builder: (context, snapshot) {
                    final plan = snapshot.data;

                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(22),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.10),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.workspace_premium,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Clube de Assinaturas',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            plan == null
                                ? 'Nenhum plano ativo.'
                                : 'Plano ativo: $plan',
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Descontos especiais, prioridade em agendamentos e benefícios exclusivos.',
                            style: TextStyle(
                              color:
                                  Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.25,
            children: const [
              StatCard(
                label: 'Agendamentos',
                value: '12',
                icon: Icons.event_available_outlined,
              ),
              StatCard(
                label: 'Promoções',
                value: '8',
                icon: Icons.local_offer_outlined,
              ),
              StatCard(
                label: 'Nível',
                value: 'Gold',
                icon: Icons.workspace_premium_outlined,
              ),
              StatCard(
                label: 'Avaliação',
                value: '4.9',
                icon: Icons.star_outline,
              ),
            ],
          ),

          const SizedBox(height: 22),

          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Nome',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),

          const SizedBox(height: 14),

          TextField(
            controller: phoneCtrl,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
          ),

          const SizedBox(height: 20),

          PrimaryActionButton(
            label: 'Salvar alterações',
            icon: Icons.save_outlined,
            onPressed: _editProfile,
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text('Sair da conta'),
          ),

          const SizedBox(height: 24),

          Text(
            AppBrand.slogan,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
