import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:line_monitor/view/components/style/Styling.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  Set<Marker> markerList = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  AppBar dashboardAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: ThemeData.light().canvasColor,
      leading: Icon(Icons.menu),
      title: Text(
        "Dashboard",
        style: Style.appBarTextStyle(),
      ),
    );
  }

  Center dashboardBody() {
    setState(() {
      markerList.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId:
            MarkerId(LatLng(37.43296265331129, -122.08832357078792).toString()),
        position: LatLng(37.43296265331129, -122.08832357078792),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    return Center(
        child: GoogleMap(
      mapType: MapType.normal,
      markers: markerList,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        mapController = controller;
      },
    ));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: dashboardBody(),
    );
  }
}
