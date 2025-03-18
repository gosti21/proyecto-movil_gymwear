import 'package:flutter/material.dart';
import 'details_screen.dart';

class EncargosScreen extends StatefulWidget {
  @override
  _EncargosScreenState createState() => _EncargosScreenState();
}

class _EncargosScreenState extends State<EncargosScreen> {
  List<Map<String, dynamic>> encargos = [];

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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Agregar Encargo",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                TextField(
                    controller: clienteController,
                    decoration: InputDecoration(labelText: "Cliente")),
                TextField(
                    controller: pedidoController,
                    decoration: InputDecoration(labelText: "Pedido")),
                TextField(
                    controller: cantidadController,
                    decoration: InputDecoration(labelText: "Cantidad"),
                    keyboardType: TextInputType.number),
                TextField(
                    controller: direccionController,
                    decoration: InputDecoration(labelText: "Dirección")),
                TextField(
                    controller: fechaController,
                    decoration:
                        InputDecoration(labelText: "Fecha (YYYY-MM-DD)")),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancelar"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (clienteController.text.isNotEmpty &&
                            pedidoController.text.isNotEmpty &&
                            cantidadController.text.isNotEmpty &&
                            direccionController.text.isNotEmpty &&
                            fechaController.text.isNotEmpty) {
                          setState(() {
                            encargos.add({
                              "id": encargos.length + 1,
                              "cliente": clienteController.text,
                              "pedido": pedidoController.text,
                              "cantidad": int.parse(cantidadController.text),
                              "direccion": direccionController.text,
                              "fecha": fechaController.text,
                            });
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
      body: encargos.isEmpty
          ? Center(child: Text("No hay encargos. Agrega uno."))
          : ListView.builder(
              itemCount: encargos.length,
              itemBuilder: (context, index) {
                final encargo = encargos[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title:
                        Text("Orden #${encargo['id']} - ${encargo['pedido']}"),
                    subtitle: Text(
                        "Cliente: ${encargo['cliente']}\nFecha: ${encargo['fecha']}"),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(encargo: encargo)),
                      );
                    },
                  ),
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
