import 'package:flutter/material.dart';
import 'map.dart'; // Importa la pantalla del mapa

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> encargo;

  DetailsScreen({required this.encargo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orden #${encargo['id']}"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping, // Icono de caja de envío
                          size: 50,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(encargo['pedido'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Cantidad: ${encargo['cantidad']}"),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Text("📌 Cliente: ${encargo['cliente']}",
                        style: TextStyle(fontSize: 16)),
                    Text("📍 Dirección: ${encargo['direccion']}",
                        style: TextStyle(fontSize: 16)),
                    Text("📅 Fecha pedido: ${encargo['fecha']}",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                // Navegar a la pantalla de mapa con dirección, latitud y longitud
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(
                      direccion: encargo['direccion'],
                      lat: encargo['latitud'] ?? 0.0, // Usa 0.0 si es null
                      lng: encargo['longitud'] ?? 0.0, // Usa 0.0 si es null
                    ),
                  ),
                );
              },
              child: Text("INICIAR RECORRIDO"),
            ),
          ],
        ),
      ),
    );
  }
}
