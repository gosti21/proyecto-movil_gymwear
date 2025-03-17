import 'package:flutter/material.dart';
import 'package:gymmovil/screens/admin/encargos_screen.dart';
import 'package:gymmovil/screens/admin/entrega_screen.dart';
import 'package:gymmovil/screens/admin/reporte_screen.dart';
import 'package:gymmovil/screens/roles_screen.dart'; // Importa la pantalla de roles

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestión de Admin"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Botón de regreso
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RolesScreen()), 
              (Route<dynamic> route) => false, // Elimina todas las pantallas previas
            );
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Encargos"),
            Tab(text: "Entregado"),
            Tab(text: "Reportes"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          EncargosScreen(),
          EntregaScreen(),
          ReporteScreen(),
        ],
      ),
    );
  }
}
