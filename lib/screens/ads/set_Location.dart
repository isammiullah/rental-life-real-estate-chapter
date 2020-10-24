import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/model/nonComm_Ad.dart';
import 'package:search_map_place/search_map_place.dart';



class LocationWidget extends StatefulWidget {
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}


class _LocationWidgetState extends State<LocationWidget> {

  GoogleMapController mapController;
  LatLng selectedLocation = LatLng(33.6844, 73.0479);

  Set<Marker> _markers = Set<Marker>();
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,

      body: Container(
        child: Column(
          children: [
            SearchMapPlaceWidget(
              hasClearButton: true,
              placeType: PlaceType.address,

              placeholder: 'Enter the location',

              apiKey: 'AIzaSyBUILBxCa5yyQZawAAOpD6HII48R3haimM',

              onSelected: (Place place) async {
                Geolocation geolocation = await place.geolocation;
                selectedLocation= geolocation.coordinates;

                mapController.animateCamera(

                //  CameraUpdate.newLatLng(selectedLocation));
               //updateMarker('Marker');


                    CameraUpdate.newLatLng(geolocation.coordinates));

                mapController.animateCamera(
                    CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                //selectedLocation= geolocation.coordinates;
                print(selectedLocation);
                //userAd.location = selectedLocation;
                print("selectedLocation");


              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: SizedBox(
                  height: 600.0,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController googleMapController) {
                      setState(() {
                        mapController = googleMapController;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                        zoom: 15.0,
                        target: LatLng(selectedLocation.latitude, selectedLocation.longitude)
                    ),
                    mapType: MapType.satellite,
                    markers:
                    Set<Marker>.of (
                      <Marker>[
                        Marker(
                            onTap: () {
                              print('Tapped');
                            },
                            draggable: true,
                            markerId: MarkerId('Marker'),
                            position: LatLng(selectedLocation.latitude, selectedLocation.longitude),
                            onDragEnd: ((newPosition) {
                              selectedLocation= newPosition;
                              print(newPosition.latitude);
                              print(newPosition.longitude);
                              setState(() {

                              });
                            }))
                      ]
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}