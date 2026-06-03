import 'package:flutter/material.dart';
import '../../models/appointment_model.dart';
import '../../services/appointment_storage.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _notesCtrl = TextEditingController();

  final List<String> _services = const [
    'Corte Degradê',
    'Barba Completa',
    'Combo Barba + Corte',
    'Sobrancelha',
    'Acabamento',
  ];

  final List<String> _barbers = const [
    'Barbeiro João',
    'Barbeiro Lucas',
    'Barbeiro Pedro',
  ];

  final List<String> _times = const [
    '09:00',
    '10:00',
    '11:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
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
    setState(() => _loading = false);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
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

    await AppointmentStorage.addAppointment(
      AppointmentModel(
        service: _selectedService!,
        barber: _selectedBarber!,
        dateIso: _selectedDate!.toIso8601String(),
        time: _selectedTime!,
        notes: _notesCtrl.text.trim(),
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
      const SnackBar(content: Text('Agendamento salvo com sucesso!')),
    );
  }

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d/$m/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
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
            'Escolha o serviço, barbeiro, data e horário.',
            style: TextStyle(color: Colors.grey.shade400),
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
            borderRadius: BorderRadius.circular(18),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Data',
                prefixIcon: Icon(Icons.calendar_month),
              ),
              child: Text(
                _selectedDate == null
                    ? 'Selecionar data'
                    : _formatDate(_selectedDate!),
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
            icon: const Icon(Icons.event_available),
            label: const Text('Confirmar agendamento'),
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
                    Text('${item.barber} • ${_formatDate(item.date)} • ${item.time}'),
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