import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final String direccion;
  final double? lat;
  final double? lng;

  MapScreen({required this.direccion, this.lat, this.lng});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _centerMap() {
    if (widget.lat != null && widget.lng != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(widget.lat!, widget.lng!)),
      );
    }
  }

  // Abrir Google Maps
  void _openGoogleMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.lng}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orden #26")),
      body: Column(
        children: [
          
          Expanded(
            flex: 3,
            child: widget.lat == null || widget.lng == null
                ? Center(
                    child: Text(
                      "Ubicación no disponible",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.lat!, widget.lng!),
                      zoom: 15.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId("destino"),
                        position: LatLng(widget.lat!, widget.lng!),
                      ),
                    },
                  ),
          ),

          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "INICIAR RECORRIDO",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: _openGoogleMaps,
                        child: Text("Google Maps"),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.direccion,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          
                        },
                        child: Text("PEDIDO ENTREGADO"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          
                        },
                        child: Text("REPORTAR INCIDENTE"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
