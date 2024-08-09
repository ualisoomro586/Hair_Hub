import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/src/places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hair_hub/barber_signup.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

import 'package:flutter_google_places/flutter_google_places.dart';

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late GoogleMapController mapController;
  LatLng _currentPosition = LatLng(0.0, 0.0);
  LatLng _selectedPosition = LatLng(0.0, 0.0);
  Marker? _marker;
  final loc.Location _location = loc.Location();
  final TextEditingController _searchController = TextEditingController();
  final String _googleApiKey = 'AIzaSyB_-uOyQimLqBkDW_Vr8d88GX6Qk0lyksI';
  bool _isloading = false;
  String? address;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    var currentLocation = await _location.getLocation();
    setState(() {
      _currentPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      _selectedPosition = _currentPosition;
      _marker = Marker(
          markerId: MarkerId("Selected location"), position: _selectedPosition);
    });
    mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      _selectedPosition = latLng;
      _marker = Marker(
        markerId: MarkerId('selected_location'),
        position: _selectedPosition,
      );
    });
    mapController.animateCamera(CameraUpdate.newLatLng(_selectedPosition));
  }

  void _get_current_location() {
    setState(() {
      _selectedPosition = _currentPosition;
      _marker = Marker(
          markerId: MarkerId('selected_location'), position: _selectedPosition);
    });
    mapController.animateCamera(CameraUpdate.newLatLng(_selectedPosition));
  }

  void _searchPlace() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: _googleApiKey,
      mode: Mode.overlay, // Mode.fullscreen
      language: "en",
      components: [Component(Component.country, "us")],
    );

    if (p != null) {
      PlacesDetailsResponse detail =
          await GoogleMapsPlaces(apiKey: _googleApiKey)
              .getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      setState(() {
        _currentPosition = LatLng(lat, lng);
        mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
      });
    }
  }

  void _saveLocation() async {
    setState(() {
      _isloading = true;
    });
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _selectedPosition.latitude, _selectedPosition.longitude);
    address =
        '${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.country}';

    await FirebaseFirestore.instance.collection('barber').add({
      'address': address,
      'location':
          GeoPoint(_selectedPosition.latitude, _selectedPosition.longitude),
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Location saved: $address')));
    setState(() {
      _isloading = false;
    });
    print(address);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => sign_up(value: address)));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _currentPosition, zoom: 15.0),
            onMapCreated: (controller) => mapController = controller,
            // markers: {
            //   Marker(
            //       markerId: MarkerId('currentLocation'),
            //       position: _currentPosition),
            // },
            markers: _marker != null ? {_marker!} : {},
            onTap: _onMapTapped,
          ),
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for a place...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.only(left: 15, right: 15),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchPlace,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            right: 46,
            // right: 50,
            child: ElevatedButton(
              onPressed: _saveLocation,
              child: _isloading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(236, 183, 43, 1),
                        strokeWidth: 2.0,
                      ),
                    )
                  : Text('Save Location'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF404040),
                  foregroundColor: Color.fromRGBO(236, 183, 43, 1),
                  fixedSize: Size(width * 0.4, height * 0.01)),
            ),
          ),
          Positioned(
              bottom: 50,
              left: 10,
              child: ElevatedButton(
                onPressed: _get_current_location,
                child: Text("Current Location"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(236, 183, 43, 1),
                    foregroundColor: Color(0xFF404040),
                    fixedSize: Size(width * 0.43, height * 0.01)),
              ))
        ],
      ),
    );
  }
}



// class LocationPickerScreen extends StatefulWidget {
//   @override
//   _LocationPickerScreenState createState() => _LocationPickerScreenState();
// }

// class _LocationPickerScreenState extends State<LocationPickerScreen> {
//   late GoogleMapController _mapController;
//   LatLng? _pickedLocation;
//   String? _pickedAddress;
//   bool _isLoading = false;

//   Future<void> _getCurrentLocation() async {
//     loc.Location location = loc.Location();
//     loc.LocationData locationData = await location.getLocation();
//     _mapController.animateCamera(CameraUpdate.newLatLng(
//       LatLng(locationData.latitude!, locationData.longitude!),
//     ));
//   }

//   Future<void> _getAddressFromLatLng(LatLng position) async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       Placemark place = placemarks[0];
//       setState(() {
//         _pickedAddress = "${place.name},${place.locality} ${place.country},";
//       });
//     } catch (e) {
//       print(e);
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   Future<void> _saveLocation() async {
//     if (_pickedLocation == null || _pickedAddress == null) return;

//     try {
//       await FirebaseFirestore.instance.collection('barber').add({
//         'location': _pickedAddress,
//         'latitude': _pickedLocation!.latitude,
//         'longitude': _pickedLocation!.longitude,
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Location saved successfully!')),
//       );
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pick Your Location'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: LatLng(37.7749, -122.4194), // Default to San Francisco
//               zoom: 14,
//             ),
//             onMapCreated: (controller) {
//               _mapController = controller;
//               _getCurrentLocation();
//             },
//             onTap: (position) {
//               setState(() {
//                 _pickedLocation = position;
//                 _pickedAddress = null;
//               });
//               _getAddressFromLatLng(position);
//             },
//             markers: _pickedLocation == null
//                 ? {}
//                 : {
//                     Marker(
//                       markerId: MarkerId('picked-location'),
//                       position: _pickedLocation!,
//                     ),
//                   },
//           ),
//           if (_isLoading) Center(child: CircularProgressIndicator()),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _saveLocation,
//         child: Icon(Icons.save),
//       ),
//     );
//   }
// }

// class SetLocationScreen extends StatefulWidget {
//   @override
//   _SetLocationScreenState createState() => _SetLocationScreenState();
// }

// class _SetLocationScreenState extends State<SetLocationScreen> {
//   GoogleMapController? _controller;
//   LatLng _currentPosition = LatLng(0, 0);
//   final Location _location = Location();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   Future<void> _getLocation() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await _location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await _location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     final locationData = await _location.getLocation();
//     setState(() {
//       _currentPosition =
//           LatLng(locationData.latitude!, locationData.longitude!);
//     });

//     _controller?.animateCamera(
//       CameraUpdate.newLatLng(_currentPosition),
//     );
//   }

//   Future<void> _saveLocation() async {
//     await _firestore.collection('barber').add({
//       'location':
//           GeoPoint(_currentPosition.latitude, _currentPosition.longitude),
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Location saved successfully')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Set Location'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: _currentPosition,
//               zoom: 14.0,
//             ),
//             onMapCreated: (GoogleMapController controller) {
//               _controller = controller;
//             },
//             markers: {
//               Marker(
//                 markerId: MarkerId('currentLocation'),
//                 position: _currentPosition,
//                 draggable: true,
//                 onDragEnd: (newPosition) {
//                   setState(() {
//                     _currentPosition = newPosition;
//                   });
//                 },
//               ),
//             },
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             right: 20,
//             child: ElevatedButton(
//               onPressed: _saveLocation,
//               child: Text('Save Location'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
