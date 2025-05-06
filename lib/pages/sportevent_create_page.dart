import 'package:flutter/material.dart';
import '../models/sportevent_model.dart';
import '../services/sportevent_service.dart';

class CreateSporteventPage extends StatefulWidget {
  const CreateSporteventPage({super.key});

  @override
  State<CreateSporteventPage> createState() => _CreateSporteventPageState();
}

class _CreateSporteventPageState extends State<CreateSporteventPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = SporteventService();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _maxParticipantsController = TextEditingController();
  bool _isOutdoor = false;
  bool _registrationOpen = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _maxParticipantsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newEvent = Sportevent(
        id: 0,
        title: _titleController.text,
        description: _descriptionController.text,
        location: _locationController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        maxParticipants: int.parse(_maxParticipantsController.text),
        isOutdoor: _isOutdoor,
        registrationOpen: _registrationOpen,
      );

      try {
        await _service.createEvent(newEvent);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Evento creado correctamente')));
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Evento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) => value!.isEmpty ? 'Ingrese un título' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) => value!.isEmpty ? 'Ingrese una descripción' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Ubicación'),
                validator: (value) => value!.isEmpty ? 'Ingrese una ubicación' : null,
              ),
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Fecha de inicio (YYYY-MM-DDTHH:MM:SS)'),
                validator: (value) => value!.isEmpty ? 'Ingrese la fecha de inicio' : null,
              ),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(labelText: 'Fecha de fin (YYYY-MM-DDTHH:MM:SS)'),
                validator: (value) => value!.isEmpty ? 'Ingrese la fecha de fin' : null,
              ),
              TextFormField(
                controller: _maxParticipantsController,
                decoration: const InputDecoration(labelText: 'Máx. Participantes'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Ingrese un número' : null,
              ),
              SwitchListTile(
                title: const Text('¿Es al aire libre?'),
                value: _isOutdoor,
                onChanged: (value) => setState(() => _isOutdoor = value),
              ),
              SwitchListTile(
                title: const Text('¿Inscripción abierta?'),
                value: _registrationOpen,
                onChanged: (value) => setState(() => _registrationOpen = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Crear Evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
