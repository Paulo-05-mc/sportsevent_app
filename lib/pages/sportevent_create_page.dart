import 'package:flutter/material.dart';
import '../services/sportevent_service.dart';
import '../models/sportevent_model.dart';

class CreateSporteventPage extends StatefulWidget {
  const CreateSporteventPage({super.key});

  @override
  State<CreateSporteventPage> createState() => _CreateSporteventPageState();
}

class _CreateSporteventPageState extends State<CreateSporteventPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = SporteventService();

  String title = '';
  String description = '';
  String location = '';
  String startDate = '';
  String endDate = '';
  int maxParticipants = 0;
  bool isOutdoor = true;
  bool registrationOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Evento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                onChanged: (val) => title = val,
                validator: (val) => val!.isEmpty ? 'Ingrese título' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                onChanged: (val) => description = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ubicación'),
                onChanged: (val) => location = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fecha inicio (YYYY-MM-DDTHH:MM:SS)'),
                onChanged: (val) => startDate = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fecha fin (YYYY-MM-DDTHH:MM:SS)'),
                onChanged: (val) => endDate = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Máx. Participantes'),
                keyboardType: TextInputType.number,
                onChanged: (val) => maxParticipants = int.tryParse(val) ?? 0,
              ),
              SwitchListTile(
                title: const Text('Es al aire libre'),
                value: isOutdoor,
                onChanged: (val) => setState(() => isOutdoor = val),
              ),
              SwitchListTile(
                title: const Text('Inscripción abierta'),
                value: registrationOpen,
                onChanged: (val) => setState(() => registrationOpen = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newEvent = Sportevent(
                      id: 0, // Se ignora al enviar
                      title: title,
                      description: description,
                      location: location,
                      startDate: startDate,
                      endDate: endDate,
                      maxParticipants: maxParticipants,
                      isOutdoor: isOutdoor,
                      registrationOpen: registrationOpen,
                    );
                    try {
                      await _service.createEvent(newEvent);
                      Navigator.pop(context, true); // vuelve a la página anterior
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error al crear evento')),
                      );
                    }
                  }
                },
                child: const Text('Crear Evento'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
