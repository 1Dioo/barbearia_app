/*
  appointments_screen.dart

  Esta tela permite que o usuário realize agendamentos de serviços
  disponíveis na barbearia.

  O usuário pode:
  - Escolher um tipo de serviço.
  - Selecionar um barbeiro.
  - Definir uma data para o atendimento.
  - Escolher um horário disponível.
  - Informar observações adicionais.
  - Efetuar o pagamento do serviço.

  Após a confirmação do pagamento, o agendamento é salvo
  utilizando o serviço AppointmentStorage e exibido na
  lista de agendamentos do usuário.
*/

import 'package:flutter/material.dart';
import '../../models/appointment_model.dart';
import '../../services/appointment_storage.dart';
import '../payments/payment_screen.dart';
import '../gallery/gallery_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _notesCtrl = TextEditingController();

  final List<String> _services = const [
    'Corte Degradê',
    'Low Fade',
    'Mid Fade',
    'Social Clássico',
    'Corte Americano',
    'Buzz Cut',
    'Moicano',
    'Barba Completa',
    'Combo Barba + Corte',
    'Sobrancelha',
    'Acabamento',
  ];

  final List<String> _barbers = const [
    'Barbeiro João',
    'Barbeiro Lucas',
    'Barbeiro Pedro',
    'Barbeiro Rodrigo',
    'Barbeiro Gabriel',
  ];

  final List<String> _times = const [
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
  ];

  String? _selectedService;
  String? _selectedBarber;
  String? _selectedTime;
  DateTime? _selectedDate;

  bool _loading = false;
  List<AppointmentModel> _appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadAppointments() async {
    setState(() => _loading = true);
    _appointments = await AppointmentStorage.getAppointmentsForCurrentUser();
    if (!mounted) return;
    setState(() => _loading = false);
  }

  double _getServicePrice(String service) {
    switch (service) {
      case 'Corte Degradê':
        return 35.0;
      case 'Low Fade':
        return 35.0;
      case 'Mid Fade':
        return 35.0;
      case 'Social Clássico':
        return 30.0;
      case 'Corte Americano':
        return 40.0;
      case 'Buzz Cut':
        return 25.0;
      case 'Moicano':
        return 40.0;
      case 'Barba Completa':
        return 25.0;
      case 'Combo Barba + Corte':
        return 55.0;
      case 'Sobrancelha':
        return 10.0;
      case 'Acabamento':
        return 15.0;
      default:
        return 20.0;
    }
  }

  String _money(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      locale: const Locale('pt', 'BR'),
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      helpText: 'Selecionar data',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      fieldLabelText: 'Data',
      fieldHintText: 'dd/mm/aaaa',
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _saveAppointment() async {
    if (_selectedService == null ||
        _selectedBarber == null ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha serviço, barbeiro, data e horário.'),
        ),
      );
      return;
    }

    final price = _getServicePrice(_selectedService!);

    final paymentMethod = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          title: 'Pagamento do agendamento',
          subtitle: _selectedService!,
          amount: price,
          highlights: [
            _selectedBarber!,
            _selectedTime!,
            _selectedDate == null
                ? ''
                : '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
          ].where((item) => item.isNotEmpty).toList(),
        ),
      ),
    );

    if (paymentMethod == null) return;

    await AppointmentStorage.addAppointment(
      AppointmentModel(
        service: _selectedService!,
        barber: _selectedBarber!,
        dateIso: _selectedDate!.toIso8601String(),
        time: _selectedTime!,
        notes: _notesCtrl.text.trim(),
        paymentMethod: paymentMethod,
        price: price,
      ),
    );

    _notesCtrl.clear();

    setState(() {
      _selectedService = null;
      _selectedBarber = null;
      _selectedDate = null;
      _selectedTime = null;
    });

    await _loadAppointments();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pagamento aprovado via $paymentMethod. Agendamento salvo com sucesso!',
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d/$m/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final priceText = _selectedService == null
        ? null
        : _money(_getServicePrice(_selectedService!));

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            'Agendar corte',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Escolha seu corte, veja a galeria, selecione barbeiro, data e horário. O pagamento será solicitado ao confirmar.',
            style: TextStyle(color: Colors.grey.shade400, height: 1.35),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Inspire-se antes de agendar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Veja nossa galeria de cortes e escolha o estilo ideal para você.',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GalleryScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Ver Galeria de Cortes'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _selectedService,
            decoration: const InputDecoration(
              labelText: 'Serviço',
              prefixIcon: Icon(Icons.content_cut),
            ),
            items: _services
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _selectedService = value),
          ),
          if (priceText != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Valor do serviço: $priceText',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: _selectedBarber,
            decoration: const InputDecoration(
              labelText: 'Barbeiro',
              prefixIcon: Icon(Icons.person_outline),
            ),
            items: _barbers
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _selectedBarber = value),
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Escolher data do atendimento'
                          : _formatDate(_selectedDate!),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _times.map((time) {
              final selected = _selectedTime == time;
              return ChoiceChip(
                label: Text(time),
                selected: selected,
                onSelected: (_) => setState(() => _selectedTime = time),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _notesCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Observações',
              prefixIcon: Icon(Icons.notes_outlined),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: _saveAppointment,
            icon: const Icon(Icons.lock_outline),
            label: const Text('Pagar e agendar'),
          ),
          const SizedBox(height: 24),
          Text(
            'Meus agendamentos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (_loading)
            const Center(child: CircularProgressIndicator())
          else if (_appointments.isEmpty)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Text('Nenhum agendamento salvo ainda.'),
            )
          else
            ..._appointments.reversed.map(
              (item) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.service,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${item.barber} • ${_formatDate(item.date)} • ${item.time}',
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Pagamento: ${item.paymentMethod} • ${_money(item.price)}',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                    if (item.notes.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        item.notes,
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
