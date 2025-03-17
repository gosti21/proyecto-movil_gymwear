import 'package:flutter/material.dart';

class DespachoScreen extends StatelessWidget {
  final List<Map<String, dynamic>> encargos;
  final Function(Map<String, dynamic>, String) actualizarEstado;

  DespachoScreen({required this.encargos, required this.actualizarEstado});

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
        leading: Icon(Icons.local_shipping, color: Colors.blue),
        title: Text("Orden #${encargo['id']} - ${encargo['pedido']}"),
        subtitle: Text("Cliente: ${encargo['cliente']}\nFecha: ${encargo['fecha']}"),
        trailing: ElevatedButton(
          onPressed: () => actualizarEstado(encargo, "En camino"),
          child: Text("Enviar"),
        ),
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
          Text("No hay órdenes"),
        ],
      ),
    );
  }
}
