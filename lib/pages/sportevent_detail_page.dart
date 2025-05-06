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
            Text("Descripción: ${event.description}"),
            Text("Ubicación: ${event.location}"),
            Text("Inicio: ${event.startDate}"),
            Text("Fin: ${event.endDate}"),
            Text("Máx. Participantes: ${event.maxParticipants}"),
            Text("¿Al aire libre?: ${event.isOutdoor ? 'Sí' : 'No'}"),
            Text("Registro abierto: ${event.registrationOpen ? 'Sí' : 'No'}"),
          ],
        ),
      ),
    );
  }
}
