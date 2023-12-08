import 'package:flutter/cupertino.dart';
<<<<<<< HEAD
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
=======
import 'package:flutter/material.dart';
>>>>>>> origin/master
import 'package:geocoding/geocoding.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
<<<<<<< HEAD
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
=======

>>>>>>> origin/master
import '../Home/Reservation.dart';

import 'Reservation.dart';
import '../client_profile/client_profile.dart';
import '../client_reservations/client_reservations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dine_easy/client/client_signin/token_manager.dart';

class RestaurantHomePage extends StatefulWidget {
  //consturtor for home screen which recived name parameter
  RestaurantHomePage({Key? key, required this.name});
  String name;

  @override
  _RestaurantHomePageState createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  bool isDataLoaded = false;
  var parsedData;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> originalData = [];
  List<Map<String, dynamic>> restaurantsWithin10Km = [];
  int _selectedIndex = 1; //default index of homepage
  List<Map<String, dynamic>> currentList = []; //for reset button
  late String Token;
<<<<<<< HEAD
  bool showFilterButtons = false;
=======
>>>>>>> origin/master

  @override
  void initState() {
    super.initState();
    fetchData();
<<<<<<< HEAD
    // calculateAndFilterRestaurantsWithin10Km();
=======
    calculateAndFilterRestaurantsWithin10Km();
>>>>>>> origin/master
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Start color (#F5F5DC)
            Color(0xFF2b1b17),
            Color(0xFF0c0908),
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topCenter,
          stops: [0.1, 0.5],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'HOME',
            style: TextStyle(fontFamily: 'Pacifico'),
          ),
          backgroundColor: const Color(0xFF020403),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await fetchData();
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
<<<<<<< HEAD
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search for food...',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: filterData,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showFilterButtons = !showFilterButtons;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                      backgroundColor: !showFilterButtons?Colors.black12:Colors.blueGrey,
                      surfaceTintColor: Colors.deepOrange,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        side:const BorderSide(
                          color: Colors.orange,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                      child: Text("Filter"),
                    ),
                  ],
                ),
              ),
              if (showFilterButtons) ...[
                Row(
                  children: [
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 9,
                        shadowColor: Colors.black87,
=======
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search for food...',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: filterData,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0,left: 14),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 9,
                        shadowColor: Colors.white38,
                        backgroundColor: const Color(0xFF22A86F),
>>>>>>> origin/master
                      ),
                      onPressed: () {
                        calculateAndFilterRestaurantsWithin10Km();
                      },
                      child: Text("Nearby"),
                    ),
<<<<<<< HEAD
                    const SizedBox(width: 16),
                    ElevatedButton(onPressed:(){
                      setState(() {
                        print(originalData);
                        restaurantsWithin10Km=[];
                        data=originalData;
                        print("data after reset is:::${data}");
                        setState(() {
                        });
                      });
                    },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.black87,
                      ),
                      child: const Text("Reset"),
                    ),
                  ],
                ),
              ],
                Expanded(
                  child: isDataLoaded
                      ? buildDataList(restaurantsWithin10Km.isNotEmpty
                          ? restaurantsWithin10Km
                          : data)
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.teal,
                        )),
                ),
              ],
=======
                  ),
                  ElevatedButton(onPressed:(){
                    setState(() {
                      print(originalData);
                      restaurantsWithin10Km=[];
                      data=originalData;
                      print("data after reset is:::${data}");
                      setState(() {
                      });
                    });
                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22A86F),
                    ),
                    child: const Text("Reset"),),
                ],
              ),
              Expanded(
                child: isDataLoaded
                    ? buildDataList(restaurantsWithin10Km.isNotEmpty
                        ? restaurantsWithin10Km
                        : data)
                    : Center(child: CircularProgressIndicator()),
              ),
            ],
>>>>>>> origin/master
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 8,
          backgroundColor: const Color(0xFF2b1b17),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Reservations',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Future<void> tokenget() async {
    final temptoken = await TokenManager.getToken();
    if (temptoken != null) {
      setState(() {
        Token = temptoken;
      });
      print("token assigned:::$Token");
    }
  }

  void _onItemTapped(int index) async {
    await tokenget();
    setState(() {
      _selectedIndex = index;
    });
    print("index is::${index}");
    if (index == 0) {
      // Navigate to Menu screen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(name: widget.name, token: Token)),
      );
    } else if (index == 2) {
      // Navigate to Reservations screen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                reservations(name: widget.name, token: Token)),
      );
    }
  }

  Future<void> calculateAndFilterRestaurantsWithin10Km() async {
    try {
      // Get the customer's current location
      final Position customerLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      // print("khan123");

      // Clear the previous list of restaurants within 10 km
      restaurantsWithin10Km.clear();

      for (var restaurant in data) {
        // Use geocoding to convert the restaurant's address into coordinates
        List<Location> locations =
            await locationFromAddress(restaurant['address']);
        if (locations.isNotEmpty) {
          double restaurantLatitude = locations[0].latitude;
          double restaurantLongitude = locations[0].longitude;

          // Calculate the distance between the customer's location and the restaurant
          double distance = Geolocator.distanceBetween(
            customerLocation.latitude,
            customerLocation.longitude,
            restaurantLatitude,
            restaurantLongitude,
          );

          // Print the distance (in meters)
          double distanceIntoKiloMeter = distance / 1000;

          if (distanceIntoKiloMeter <= 10) {
            // Add the restaurant to the list of restaurants within 10 km
            restaurantsWithin10Km.add(restaurant);
          }
          print('Distance to restaurant: $distanceIntoKiloMeter kilo meters');
        } else {
          print('Unable to determine restaurant coordinates from address.');
        }
      }
      if (restaurantsWithin10Km.isEmpty) {
<<<<<<< HEAD
        if (kDebugMode) {
          print("No restaurant in range");
        }
        Fluttertoast.showToast(
          msg: "No Restaurant in range.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
=======
        print("No restaurant in range");
>>>>>>> origin/master
      }
      // Update the UI with the filtered data
      setState(() {});
    } catch (e) {
      print('Error during geocoding or distance calculation: $e');
    }
  }

  Future<void> fetchData() async {
    try {
      print("sending request");
      final response = await http.get(Uri.parse(
          'https://sparkling-sarong-bass.cyclic.app/customer/signin/home'));
      if (response.statusCode == 200) {
        parsedData = parseJsonResponse(response.body);
        setState(() {
          data = parsedData;
          originalData = parsedData;
          isDataLoaded = true;
<<<<<<< HEAD
          currentList = data;
=======
          currentList=data;
>>>>>>> origin/master
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching data: $e');
    }
  }

  void filterData(String query) {
    if (query.isEmpty) {
      setState(() {
        data = originalData;
      });
    } else {
      final filteredData = originalData.where((item) {
        final name = item['name'].toString().toLowerCase();
        final address = item['address'].toString().toLowerCase();
        return name.contains(query.toLowerCase()) ||
            address.contains(query.toLowerCase());
      }).toList();
      setState(() {
        data = filteredData;
      });
    }
  }

  List<Map<String, dynamic>> parseJsonResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed;
  }

  Widget buildDataList(List<Map<String, dynamic>> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        print(item);
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Reservation(
                    restaurantData: item,
                    name: widget.name,
                  ),
                ));
          },
          child: Card(
<<<<<<< HEAD
            // color: const Color(0xFF292929),
            //   color: const Color.fromRGBO(87 , 90, 94, 0.9),
            // color: Colors.deepPurple.shade900,
            color: const Color.fromRGBO(
                87, 90, 94, 1.0),
=======
            color: const Color(0xFF292929),
>>>>>>> origin/master
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            elevation: 4.0,
            child: Container(
              width: 120,
              height: 120,
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
<<<<<<< HEAD
                                height: 8,
                              ),
                              CircularProfileAvatar(
                                '',
                                radius: 43,
                                borderColor: Colors.white70,
                                borderWidth: 2,
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.transparent,
                                child: CircleAvatar(
                                  // radius: 45,
                                  backgroundColor: Colors.black38,
                                  // backgroundImage:
                                  //     AssetImage("assets/images/13.jpg"),
                                  child: Text(
                                    item['name'][0],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 36.0,
                                    ),
=======
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.black38,
                                // backgroundImage:
                                //     AssetImage("assets/images/13.jpg"),
                                child: Text(
                                  item['name'][0],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36.0,
>>>>>>> origin/master
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${item['name']}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.5,
<<<<<<< HEAD
                                  fontWeight: FontWeight.w500,
=======
>>>>>>> origin/master
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Address: ${item['address']}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
