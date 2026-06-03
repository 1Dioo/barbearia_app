import 'package:flutter/material.dart';
import '../../services/subscription_storage.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  String? currentPlan;
  DateTime? startedAt;
  bool loading = true;

  final plans = const [
    _PlanData(
      name: 'Essencial',
      price: 'R\$ 19,90/mês',
      subtitle: 'Para quem quer desconto fixo e praticidade.',
      benefits: [
        '5% de desconto em serviços',
        'Prioridade em horários',
        'Promoções exclusivas',
      ],
    ),
    _PlanData(
      name: 'Premium',
      price: 'R\$ 34,90/mês',
      subtitle: 'O plano mais equilibrado para clientes frequentes.',
      benefits: [
        '10% de desconto em serviços',
        '1 hidratação por mês',
        'Prioridade alta na agenda',
        'Combos promocionais',
      ],
    ),
    _PlanData(
      name: 'VIP',
      price: 'R\$ 59,90/mês',
      subtitle: 'A experiência completa com vantagens máximas.',
      benefits: [
        '15% de desconto em serviços',
        'Prioridade máxima',
        'Brinde mensal',
        'Combo exclusivo VIP',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    currentPlan = await SubscriptionStorage.getCurrentPlan();
    startedAt = await SubscriptionStorage.getStartedAt();
    setState(() => loading = false);
  }

  Future<void> _subscribe(String planName) async {
    await SubscriptionStorage.subscribe(planName);
    await _load();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Plano $planName ativado com sucesso!')),
    );
  }

  Future<void> _cancelPlan() async {
    await SubscriptionStorage.cancel();
    await _load();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Assinatura cancelada.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clube de Assinaturas'),
        actions: [
          if (currentPlan != null)
            TextButton(
              onPressed: _cancelPlan,
              child: const Text('Cancelar'),
            ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(18),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assine e ganhe vantagens reais',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Mais desconto, mais prioridade e uma experiência premium para o cliente.',
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        currentPlan == null
                            ? 'Nenhum plano ativo no momento.'
                            : 'Plano ativo: $currentPlan',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      if (startedAt != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Início: ${startedAt!.day.toString().padLeft(2, '0')}/${startedAt!.month.toString().padLeft(2, '0')}/${startedAt!.year}',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                ...plans.map(
                  (plan) => _PlanCard(
                    data: plan,
                    active: currentPlan == plan.name,
                    onSubscribe: () => _subscribe(plan.name),
                  ),
                ),
              ],
            ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final _PlanData data;
  final bool active;
  final VoidCallback onSubscribe;

  const _PlanCard({
    required this.data,
    required this.active,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: active
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                data.price,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data.subtitle,
            style: TextStyle(color: Colors.grey.shade400),
          ),
          const SizedBox(height: 12),
          ...data.benefits.map(
            (benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(benefit)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: active ? null : onSubscribe,
            child: Text(active ? 'Plano ativo' : 'Assinar plano'),
          ),
        ],
      ),
    );
  }
}

class _PlanData {
  final String name;
  final String price;
  final String subtitle;
  final List<String> benefits;

  const _PlanData({
    required this.name,
    required this.price,
    required this.subtitle,
    required this.benefits,
  });
}