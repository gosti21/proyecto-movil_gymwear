import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DespachoScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Órdenes en Despacho")),
      body: StreamBuilder(
        stream: _firestore
            .collection('encargos')
            .where('estado', isEqualTo: 'Despachado')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final encargos = snapshot.data!.docs;

          if (encargos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hourglass_empty, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No hay órdenes en despacho"),
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
                  leading: const Icon(Icons.local_shipping, color: Colors.blue),
                  title: Text("Orden #${encargo.id} - ${encargo['pedido']}"),
                  subtitle: Text(
                      "Cliente: ${encargo['cliente']}\nFecha: ${encargo['fecha']}"),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      // 🔹 Cambiar el estado en Firestore
                      await _firestore.collection('encargos').doc(encargo.id).update({
                        'estado': 'En Camino',
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Botón naranja
                    ),
                    child: const Text("Empezar",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
