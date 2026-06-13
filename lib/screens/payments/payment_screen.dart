/*
 * Tela de pagamento do aplicativo.
 * Permite selecionar uma forma de pagamento
 * e simula a confirmação da compra ou assinatura.
 */

import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final double amount;
  final List<String> highlights;

  const PaymentScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.highlights = const [],
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedMethod;
  bool processing = false;

  final methods = const [
    _PaymentMethodData(
      name: 'PIX',
      icon: Icons.qr_code_2,
      subtitle: 'Pagamento instantâneo e prático',
      details: 'Use QR Code ou chave PIX para confirmar em segundos.',
    ),
    _PaymentMethodData(
      name: 'Cartão de crédito',
      icon: Icons.credit_card,
      subtitle: 'Parcelamento e aprovação rápida',
      details: 'Ideal para compras maiores ou assinatura mensal.',
    ),
    _PaymentMethodData(
      name: 'Cartão de débito',
      icon: Icons.account_balance,
      subtitle: 'Cobrança direta na conta',
      details: 'Pagamento simples, direto e sem parcelas.',
    ),
    _PaymentMethodData(
      name: 'Carteiras digitais',
      icon: Icons.account_balance_wallet_outlined,
      subtitle: 'Google Pay e Apple Pay',
      details: 'Finalize usando a carteira digital do celular.',
    ),
  ];

  String _money(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Future<void> _confirm() async {
    if (selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma forma de pagamento.'),
        ),
      );
      return;
    }

    setState(() => processing = true);
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    Navigator.pop(context, selectedMethod);
  }

  @override
  Widget build(BuildContext context) {
    final gold = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.subtitle,
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: gold.withOpacity(0.10),
                    border: Border.all(
                      color: gold.withOpacity(0.20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total a pagar',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _money(widget.amount),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.highlights.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.highlights
                        .map(
                          (item) => Chip(
                            label: Text(item),
                            backgroundColor: gold.withOpacity(0.10),
                            side: BorderSide(color: gold.withOpacity(0.20)),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Escolha a forma de pagamento',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 12),

          ...methods.map(
            (method) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _PaymentMethodCard(
                data: method,
                selected: selectedMethod == method.name,
                onTap: () => setState(() => selectedMethod = method.name),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              'Pagamento simulado para apresentação e fluxo interno do app. Para cobrança real depois, você pode integrar Mercado Pago, Asaas ou Stripe.',
              style: TextStyle(color: Colors.grey.shade400, height: 1.4),
            ),
          ),

          const SizedBox(height: 18),

          FilledButton.icon(
            onPressed: processing ? null : _confirm,
            icon: processing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.lock_outline),
            label: Text(
              processing
                  ? 'Processando...'
                  : 'Confirmar pagamento ${_money(widget.amount)}',
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodData {
  final String name;
  final IconData icon;
  final String subtitle;
  final String details;

  const _PaymentMethodData({
    required this.name,
    required this.icon,
    required this.subtitle,
    required this.details,
  });
}

class _PaymentMethodCard extends StatelessWidget {
  final _PaymentMethodData data;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gold = Theme.of(context).colorScheme.primary;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? gold : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: gold.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(data.icon, color: gold),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.subtitle,
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.details,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? gold : Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
