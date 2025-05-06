import 'package:flutter/material.dart';
import '../models/sportevent_model.dart';
import '../services/sportevent_service.dart';
import 'sportevent_create_page.dart';

class SporteventListPage extends StatefulWidget {
  const SporteventListPage({super.key});

  @override
  State<SporteventListPage> createState() => _SporteventListPageState();
}

class _SporteventListPageState extends State<SporteventListPage> {
  final SporteventService _service = SporteventService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eventos Deportivos')),
      body: FutureBuilder<List<Sportevent>>(
        future: _service.getAllEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay eventos disponibles.'));
          } else {
            final events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.location),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateSporteventPage()),
          );
          if (result == true) {
            setState(() {}); // Recargar lista
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
