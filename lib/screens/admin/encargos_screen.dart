import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'details_screen.dart';

class EncargosScreen extends StatefulWidget {
  @override
  _EncargosScreenState createState() => _EncargosScreenState();
}

class _EncargosScreenState extends State<EncargosScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _mostrarFormularioAgregarEncargo() {
    TextEditingController clienteController = TextEditingController();
    TextEditingController pedidoController = TextEditingController();
    TextEditingController cantidadController = TextEditingController();
    TextEditingController direccionController = TextEditingController();
    TextEditingController fechaController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Agregar Encargo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                TextField(controller: clienteController, decoration: InputDecoration(labelText: "Cliente")),
                TextField(controller: pedidoController, decoration: InputDecoration(labelText: "Pedido")),
                TextField(controller: cantidadController, decoration: InputDecoration(labelText: "Cantidad"), keyboardType: TextInputType.number),
                TextField(controller: direccionController, decoration: InputDecoration(labelText: "Dirección")),
                TextField(controller: fechaController, decoration: InputDecoration(labelText: "Fecha (YYYY-MM-DD)")),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (clienteController.text.isNotEmpty &&
                            pedidoController.text.isNotEmpty &&
                            cantidadController.text.isNotEmpty &&
                            direccionController.text.isNotEmpty &&
                            fechaController.text.isNotEmpty) {
                          _firestore.collection('encargos').add({
                            "cliente": clienteController.text,
                            "pedido": pedidoController.text,
                            "cantidad": int.parse(cantidadController.text),
                            "direccion": direccionController.text,
                            "fecha": fechaController.text,
                            "estado": "Pendiente"
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Agregar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Encargos")),
      body: StreamBuilder(
        stream: _firestore.collection('encargos').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var encargos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: encargos.length,
            itemBuilder: (context, index) {
              var encargo = encargos[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text("Orden - ${encargo['pedido']}"),
                  subtitle: Text("Cliente: ${encargo['cliente']}\nFecha: ${encargo['fecha']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.local_shipping, color: Colors.blue),
                    onPressed: () {
                      _firestore.collection('encargos').doc(encargo.id).update({"estado": "Despachado"});
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(encargo: encargo.data() as Map<String, dynamic>),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormularioAgregarEncargo,
        child: Icon(Icons.add),
      ),
    );
  }
}
