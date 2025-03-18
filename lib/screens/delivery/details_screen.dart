import 'package:flutter/material.dart';
import 'map.dart'; 

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
                          Icons.local_shipping, 
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

                    //cambiar iconos con flutter_svg luego//
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(
                      direccion: encargo['direccion'],
                      lat: encargo['latitud'] ?? 0.0, 
                      lng: encargo['longitud'] ?? 0.0,
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
