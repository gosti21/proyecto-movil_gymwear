import 'package:flutter/material.dart';
import 'details_screen.dart';

class EnCaminoScreen extends StatelessWidget {
  final List<Map<String, dynamic>> encargos;
  final Function(Map<String, dynamic>, String) actualizarEstado;

  EnCaminoScreen({required this.encargos, required this.actualizarEstado});

  @override
  Widget build(BuildContext context) {
    return encargos.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            itemCount: encargos.length,
            itemBuilder: (context, index) {
              final encargo = encargos[index];
              return _buildEncargoItem(context, encargo);
            },
          );
  }

  Widget _buildEncargoItem(BuildContext context, Map<String, dynamic> encargo) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.directions_bike, color: Colors.orange),
        title: Text("Orden #${encargo['id']} - ${encargo['pedido']}"),
        subtitle: Text("Cliente: ${encargo['cliente']}\nDirección: ${encargo['direccion']}"),
        trailing: ElevatedButton(
          onPressed: () {
            // Navegar a details_screen.dart y enviar los datos del encargo
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(encargo: encargo),
              ),
            );
          },
          child: Text("Ver Detalles"),
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
          Text("No hay órdenes en camino"),
        ],
      ),
    );
  }
}
