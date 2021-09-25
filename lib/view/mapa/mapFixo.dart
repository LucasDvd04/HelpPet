import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:helppet/util/location.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapaFixo extends StatefulWidget {
  final double lat;
  final double long;
  MapaFixo({Key key, @required this.lat, @required this.long})
      : super(key: key);
  @override
  _MapaFixoState createState() => _MapaFixoState();
}

class _MapaFixoState extends State<MapaFixo> {
  Location l = new Location();

  // Lista de pontos adicionados ao clicar na tela <LatLng>
  List<LatLng> tappedPoints = [];
  Map<String, dynamic> local = {'lat': [], 'long': []};

// funcao que atualiza o estado do mapa e salva a coordenada na lista tappedPoints.
  void _handleTap(LatLng latlng) {
    setState(() {
      print(latlng);
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
                  latlng.longitude.toString()),
              action: SnackBarAction(
                label: 'ir até lá',
                onPressed: () => {
                  MapUtils.openMap(latlng.latitude, latlng.longitude),
                },
              ),
            ));
          },
          child: Icon(
            // Icone do marcador
            Icons.pin_drop,
            color: Colors.black,
          ),
        ),
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        // Titulo da pagina
        title: Text('Selecione a localização'),
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
    );
  }
}

class MapUtils {
  static openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Não foi possível abrir o mapa.';
    }
  }
}
