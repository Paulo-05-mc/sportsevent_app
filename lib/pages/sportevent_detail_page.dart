import 'package:flutter/material.dart';
import '../models/sportevent_model.dart';

class SporteventDetailPage extends StatelessWidget {
  final Sportevent event;

  const SporteventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descripción: ${event.description}'),
            const SizedBox(height: 8),
            Text('Ubicación: ${event.location}'),
            const SizedBox(height: 8),
            Text('Fecha inicio: ${DateTime.parse(event.startDate).toLocal()}'),
            Text('Fecha fin: ${DateTime.parse(event.endDate).toLocal()}'),
            const SizedBox(height: 8),
            Text('Participantes máximos: ${event.maxParticipants}'),
            Text('¿Es al aire libre? ${event.isOutdoor ? 'Sí' : 'No'}'),
            Text('¿Inscripción abierta? ${event.registrationOpen ? 'Sí' : 'No'}'),
          ],
        ),
      ),
    );
  }
}
