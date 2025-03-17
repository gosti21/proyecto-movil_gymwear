import 'package:flutter/material.dart';

class EntregadoScreen extends StatelessWidget {
  final List<Map<String, dynamic>> encargos;

  EntregadoScreen({required this.encargos});

  @override
  Widget build(BuildContext context) {
    return encargos.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            itemCount: encargos.length,
            itemBuilder: (context, index) {
              final encargo = encargos[index];
              return _buildEncargoItem(encargo);
            },
          );
  }

  Widget _buildEncargoItem(Map<String, dynamic> encargo) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.check_circle, color: Colors.green),
        title: Text("Orden #${encargo['id']} - ${encargo['pedido']}"),
        subtitle: Text("Entregado a: ${encargo['cliente']}"),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty, size: 80, color: Colors.grey),
          SizedBox(height: 10),
          Text("No hay órdenes entregadas"),
        ],
      ),
    );
  }
}
