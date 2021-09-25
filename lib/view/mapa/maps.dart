import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:helppet/util/location.dart';
import 'package:latlong/latlong.dart';

class Mapa extends StatefulWidget {
  final double lat;
  final double long;
  Mapa({Key key, @required this.lat, @required this.long}) : super(key: key);
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  Location l = new Location();

  // Lista de pontos adicionados ao clicar na tela <LatLng>
  List<LatLng> tappedPoints = [];
  Map<String, dynamic> local = {'lat': [], 'long': []};

// funcao que atualiza o estado do mapa e salva a coordenada na lista tappedPoints.
  void _handleTap(LatLng latlng) {
    setState(() {
      print(latlng);
      tappedPoints.clear();
      tappedPoints.add(latlng);
      local['lat'] = latlng.latitude;
      local['long'] = latlng.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (tappedPoints.isEmpty) {
      tappedPoints.add(LatLng(widget.lat, widget.long));
    }
    var markers = tappedPoints.map((latlng) {
      return Marker(
        // dimensao dos marcadores
        width: 80.0,
        height: 80.0,
        // coordenadas do marcadores.
        point: latlng,

        builder: (ctx) => GestureDetector(
          onTap: () {
            // Mostrar uma SnackBar quando clicar em um marcador
            Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text("Latitude =" +
                    latlng.latitude.toString() +
                    " :: Longitude = " +
                    latlng.longitude.toString())));
          },
          child: Icon(
            // Icone do marcador
            Icons.pin_drop,
            color: Colors.black,
          ),
        ),
      );
    }).toList();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            // Titulo da pagina
            title: Text('Selecione a localização'),

            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    Navigator.pop(context, local);
                  })
            ],
          ),
          body: FlutterMap(
            options: MapOptions(
              // Coordenada central do mapa.
              center: LatLng(widget.lat, widget.long),
              // Quantidade de zoom do mapa.
              zoom: 17,
              onTap: _handleTap,
            ),
            layers: [
              // Url do mapa.
              TileLayerOptions(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayerOptions(markers: markers)
            ],
          ),
        ));
  }
}
