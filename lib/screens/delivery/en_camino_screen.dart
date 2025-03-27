import 'package:flutter/material.dart';

class EnCaminoScreen extends StatelessWidget {
  final List<Map<String, dynamic>> encargos;
  final Function(Map<String, dynamic>, String) actualizarEstado;

  EnCaminoScreen({required this.encargos, required this.actualizarEstado});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: encargos.length,
      itemBuilder: (context, index) {
        final encargo = encargos[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(encargo['nombre'] ?? 'Sin nombre'),
            subtitle: Text("Estado: ${encargo['estado']}"),
            trailing: ElevatedButton(
              onPressed: () {
                actualizarEstado(encargo, "Entregado");
              },
              child: Text("Entregar"),
            ),
          ),
        );
      },
    );
  }
}
