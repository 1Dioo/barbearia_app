import 'package:flutter/material.dart';
import '../../services/subscription_storage.dart';
import '../payments/payment_screen.dart';

/*
 * Tela do Clube de Assinaturas.
 *
 * Permite ao usuário visualizar os planos disponíveis,
 * contratar uma assinatura, consultar informações do
 * plano ativo e cancelar a assinatura quando desejar.
 *
 * Os dados da assinatura são carregados e salvos
 * utilizando a classe SubscriptionStorage.
 */

class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  String? currentPlan;
  String? currentPaymentMethod;
  double? currentPrice;
  DateTime? startedAt;
  bool loading = true;

  final plans = const [
    _PlanData(
      name: 'Essencial',
      priceValue: 19.90,
      subtitle: 'Para quem quer desconto fixo e praticidade.',
      benefits: [
        '5% de desconto em serviços',
        'Prioridade em horários',
        'Promoções exclusivas',
      ],
    ),
    _PlanData(
      name: 'Premium',
      priceValue: 34.90,
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
      priceValue: 59.90,
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

  String _money(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Future<void> _load() async {
    currentPlan = await SubscriptionStorage.getCurrentPlan();
    currentPaymentMethod = await SubscriptionStorage.getCurrentPaymentMethod();
    currentPrice = await SubscriptionStorage.getCurrentPrice();
    startedAt = await SubscriptionStorage.getStartedAt();
    setState(() => loading = false);
  }

  Future<void> _subscribe(_PlanData plan) async {
    final paymentMethod = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          title: 'Assinatura ${plan.name}',
          subtitle: plan.subtitle,
          amount: plan.priceValue,
          highlights: plan.benefits,
        ),
      ),
    );

    if (paymentMethod == null) return;

    await SubscriptionStorage.subscribe(
      planName: plan.name,
      price: plan.priceValue,
      paymentMethod: paymentMethod,
    );

    await _load();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Plano ${plan.name} ativado com pagamento via $paymentMethod.'),
      ),
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
                      const SizedBox(height: 14),
                      Text(
                        currentPlan == null
                            ? 'Nenhum plano ativo no momento.'
                            : 'Plano ativo: $currentPlan',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      if (currentPrice != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Valor: ${_money(currentPrice!)}',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
                      if (currentPaymentMethod != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Pago via: $currentPaymentMethod',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
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
                    onSubscribe: () => _subscribe(plan),
                    moneyText: _money(plan.priceValue),
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
  final String moneyText;

  const _PlanCard({
    required this.data,
    required this.active,
    required this.onSubscribe,
    required this.moneyText,
  });

  @override
  Widget build(BuildContext context) {
    final gold = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: active ? gold : Colors.transparent,
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
                moneyText,
                style: TextStyle(
                  color: gold,
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
                    color: gold,
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
            child: Text(active ? 'Plano ativo' : 'Assinar agora'),
          ),
        ],
      ),
    );
  }
}

class _PlanData {
  final String name;
  final double priceValue;
  final String subtitle;
  final List<String> benefits;

  const _PlanData({
    required this.name,
    required this.priceValue,
    required this.subtitle,
    required this.benefits,
  });
}
