import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsScreen extends StatelessWidget {
  final String idEncargo;
  final Map<String, dynamic> encargo;

  const DetailsScreen({super.key, required this.idEncargo, required this.encargo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con botón de regreso y título
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              color: Colors.blue,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Orden #$idEncargo",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tarjeta con detalles del encargo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Colors.grey[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.grey, width: 0.8),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.local_shipping,
                              size: 40, color: Colors.blueGrey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              encargo['pedido'] ?? 'Sin información',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Cantidad
                      _detalleItem(Icons.production_quantity_limits, "Cantidad",
                          encargo['cantidad'].toString()),

                      // Cliente
                      _detalleItem(Icons.person, "Cliente",
                          encargo['cliente'] ?? 'No especificado'),

                      // Dirección
                      _detalleItem(Icons.location_on, "Dirección",
                          encargo['direccion'] ?? 'No especificado'),

                      // Fecha de pedido
                      _detalleItem(Icons.calendar_today, "Fecha pedido",
                          encargo['fecha'] ?? 'No disponible'),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Botón "Enviar a repartidor"
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  if (idEncargo.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Error: El ID del encargo no es válido')),
                    );
                    return;
                  }

                  try {
                    print("Actualizando encargo con ID: $idEncargo");

                    await FirebaseFirestore.instance
                        .collection('encargos')
                        .doc(idEncargo)
                        .update({'estado': 'Despachado'});

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Encargo enviado a repartidor')),
                    );

                    Navigator.pop(context); // Cerrar la pantalla después de enviar
                  } catch (e) {
                    print("Error al actualizar el estado: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Error al actualizar: ${e.toString()}')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Enviar a repartidor",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detalleItem(IconData icon, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            "$titulo: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(valor, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
