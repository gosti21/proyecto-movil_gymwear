import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> encargo;

  const DetailsScreen({super.key, required this.encargo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Fondo claro como en la imagen
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra superior con botón de regreso
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
                  "Orden #${encargo['id']}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Tarjeta con detalles del pedido
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: Colors.grey[50], // Color más claro para el Card
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
                    // Primera fila con ícono y título del pedido
                    Row(
                      children: [
                        const Icon(Icons.local_shipping,
                            size: 40, color: Colors.blueGrey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            encargo['pedido'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Cantidad
                    Text(
                      "Cantidad: ${encargo['cantidad']}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 12),

                    // Cliente
                    _detalleItem(Icons.person, "Cliente", encargo['cliente']),

                    // Dirección
                    _detalleItem(
                        Icons.location_on, "Dirección", encargo['direccion']),

                    // Fecha de pedido
                    _detalleItem(Icons.calendar_today, "Fecha pedido",
                        encargo['fecha']),
                  ],
                ),
              ),
            ),
          ),

          const Spacer(),

          // Botón "Enviar a repartidor"
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // Acción al presionar
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
    );
  }

  // 🔹 Widget auxiliar para mostrar un detalle con icono
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
