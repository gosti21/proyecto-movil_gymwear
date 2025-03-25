import 'package:flutter/material.dart';

class EntregadoScreen extends StatelessWidget {
  final List encargos;

  const EntregadoScreen({required this.encargos, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (encargos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 10),
            Text("No hay órdenes entregadas"),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: encargos.length,
      itemBuilder: (context, index) {
        final encargo = encargos[index];

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: const Icon(Icons.done, color: Colors.green),
            title: Text("Orden #${encargo['id']} - ${encargo['pedido']}"),
            subtitle: Text("Cliente: ${encargo['cliente']}\nFecha: ${encargo['fecha']}"),
          ),
        );
      },
    );
  }
}
