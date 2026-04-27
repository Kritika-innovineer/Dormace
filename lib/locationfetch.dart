import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'verification.dart';

class locationfetch extends StatefulWidget {
  @override
  State<locationfetch> createState() => _locationfetchState();
}

class _locationfetchState extends State<locationfetch> {
  String locationText = "";
  String statusText = "";
  String distanceText = "";

  final List<Map<String, double>> hostelPolygon = [
    {"lat": 29.173841, "lng": 75.730138},
    {"lat": 29.174174, "lng": 75.730448},
    {"lat": 29.174177, "lng": 75.731399},
    {"lat": 29.173738, "lng": 75.731327},
    {"lat": 29.173101, "lng": 75.731347},
    {"lat": 29.173672, "lng": 75.731467},
    {"lat": 29.173384, "lng": 75.731977},
    {"lat": 29.173350, "lng": 75.731987},
    {"lat": 29.172605, "lng": 75.732621},
    {"lat": 29.172150, "lng": 75.732735},
    {"lat": 29.171978, "lng": 75.732737},
    {"lat": 29.171943, "lng": 75.731939},
    {"lat": 29.172046, "lng": 75.731320},
    {"lat": 29.171961, "lng": 75.731000},
    {"lat": 29.171888, "lng": 75.730222},
    {"lat": 29.172429, "lng": 75.730204},
    {"lat": 29.173062, "lng": 75.730442},
  ];

  bool isPointInsidePolygon(
      double lat, double lng, List<Map<String, double>> polygon) {
    bool isInside = false;
    int i, j = polygon.length - 1;
    for (i = 0; i < polygon.length; i++) {
      if ((polygon[i]["lng"]! > lng) != (polygon[j]["lng"]! > lng) &&
          (lat <
              (polygon[j]["lat"]! - polygon[i]["lat"]!) *
                      (lng - polygon[i]["lng"]!) /
                      (polygon[j]["lng"]! - polygon[i]["lng"]!) +
                  polygon[i]["lat"]!)) {
        isInside = !isInside;
      }
      j = i;
    }
    return isInside;
  }

  Future<void> getcurrentlocation() async {
    try {
      bool islocation = await Geolocator.isLocationServiceEnabled();
      if (!islocation) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Turn ON location services")),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission denied")),
        );
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Permission denied forever, enable in settings")),
        );
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      bool isInside =
          isPointInsidePolygon(pos.latitude, pos.longitude, hostelPolygon);

      setState(() {
        locationText = "Latitude: ${pos.latitude}\nLongitude: ${pos.longitude}";
        distanceText = "Geofence Check: ${isInside ? "Passed" : "Failed"}";

        if (isInside) {
          statusText = "INSIDE hostel boundary";
        } else {
          statusText = "OUTSIDE hostel boundary";
        }
      });

      if (isInside) {
        await Future.delayed(Duration(seconds: 3));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => verificationpg()),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location fetched successfully")),
      );
    } catch (e) {
      print("ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Verify Location",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 10)
                    ]),
                child:
                    Icon(Icons.location_on, size: 70, color: Colors.blueAccent),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 32.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade100, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 15,
                          offset: Offset(0, 5))
                    ]),
                child: Column(
                  children: [
                    Text(
                      locationText.isEmpty
                          ? "Location pending..."
                          : locationText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                          height: 1.5),
                    ),
                    if (distanceText.isNotEmpty) ...[
                      SizedBox(height: 20),
                      Divider(color: Colors.grey.shade100, thickness: 2),
                      SizedBox(height: 20),
                    ],
                    Text(
                      distanceText.isEmpty ? "Status pending..." : distanceText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                    color: statusText.contains("INSIDE")
                        ? Colors.green.withOpacity(0.1)
                        : (statusText.contains("OUTSIDE")
                            ? Colors.red.withOpacity(0.1)
                            : Colors.transparent),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: statusText.contains("INSIDE")
                          ? Colors.green.shade200
                          : (statusText.contains("OUTSIDE")
                              ? Colors.red.shade200
                              : Colors.transparent),
                    )),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (statusText.isNotEmpty)
                      Icon(
                        statusText.contains("INSIDE")
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: statusText.contains("INSIDE")
                            ? Colors.green
                            : Colors.red,
                        size: 20,
                      ),
                    if (statusText.isNotEmpty) SizedBox(width: 8),
                    Text(
                      statusText.isEmpty ? "Status Pending" : statusText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: statusText.contains("INSIDE")
                            ? Colors.green.shade700
                            : (statusText.contains("OUTSIDE")
                                ? Colors.red.shade700
                                : Colors.grey.shade400),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    await getcurrentlocation();
                  },
                  child: Text("Fetch Location", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
