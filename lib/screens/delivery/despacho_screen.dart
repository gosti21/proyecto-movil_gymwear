import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DespachoScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('encargos').where('estado', isEqualTo: 'Despacho').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        
        final encargos = snapshot.data!.docs;
        
        if (encargos.isEmpty) {
          return Center(
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
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(Icons.local_shipping, color: Colors.blue),
                title: Text("Orden #${encargo.id} - ${encargo['pedido']}"),
                subtitle: Text("Cliente: ${encargo['cliente']}\nFecha: ${encargo['fecha']}"),
                trailing: ElevatedButton(
                  onPressed: () async {
                    await _firestore.collection('encargos').doc(encargo.id).update({'estado': 'En camino'});
                  },
                  child: Text("Enviar"),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
