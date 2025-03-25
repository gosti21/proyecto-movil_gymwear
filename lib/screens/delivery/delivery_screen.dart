import 'package:flutter/material.dart';
import 'despacho_screen.dart';
import 'en_camino_screen.dart';
import 'entregado_screen.dart';
import 'package:gymmovil/screens/roles_screen.dart';

class DeliveryScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  List<Map<String, dynamic>> despachados = [
    {
      "id": 1,
      "cliente": "Juan Pérez",
      "pedido": "Zapatos deportivos",
      "cantidad": 1,
      "direccion": "Av. Siempre Viva 123",
      "fecha": "2025-03-16",
      "estado": "Despachado"
    },
  ];

  List<Map<String, dynamic>> enCamino = [];
  List<Map<String, dynamic>> entregados = [];

  void actualizarEstado(Map<String, dynamic> encargo, String nuevoEstado) {
    setState(() {
      if (encargo['estado'] == "Despachado") {
        despachados.remove(encargo);
        encargo['estado'] = nuevoEstado;
        enCamino.add(encargo);
      } else if (encargo['estado'] == "En camino") {
        enCamino.remove(encargo);
        encargo['estado'] = nuevoEstado;
        entregados.add(encargo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Delivery"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => RolesScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(text: "DESPACHADO"),
              Tab(text: "EN CAMINO"),
              Tab(text: "ENTREGADO"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DespachoScreen(),
            EnCaminoScreen(
                encargos: enCamino, actualizarEstado: actualizarEstado),
            EntregadoScreen(encargos: entregados),
          ],
        ),
      ),
    );
  }
}
