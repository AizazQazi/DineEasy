import 'dart:async';
import 'dart:convert';
<<<<<<< HEAD
import 'package:blurrycontainer/blurrycontainer.dart';
=======
>>>>>>> origin/master
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../profile/profile.dart';
import '../menu/menu.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class reservations extends StatefulWidget {
  const reservations({Key? key, required this.name, required this.token})
      : super(key: key);
  final dynamic token;
  final String name;

  @override
  State<reservations> createState() => _reservationsState();
}

class _reservationsState extends State<reservations> {
  int _selectedIndex = 2; // Default index for profile screen
  Future<Map<String, dynamic>>? _reservation;
  List<dynamic> reservationIds = [];
  final ScrollController _scrollController = ScrollController();
  Completer<void> _refreshCompleter = Completer<void>();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _reservation = fetchReservations();
  }

  Future<void> _onRefresh() async {

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _reservation = fetchReservations();
    });
    _refreshController.refreshCompleted();
  }

  Future<Map<String, dynamic>> fetchReservations() async {
    final Map<String, String> reqnewdata = {"name": widget.name};
    try {
      print("sending request.......");
      final response = await http.post(
        Uri.parse(
            "https://sparkling-sarong-bass.cyclic.app/signin/restaurant/reservations"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reqnewdata),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("data is:::$data");
        final Map<String, dynamic> tempreservations = data['reservations'];
        reservationIds = tempreservations.keys.toList();
        print("keys are::::$reservationIds");
        return Future.value(data);
      } else {
        print("Error: ${response.statusCode}");
        print("error is:::${response.body}");
        throw Exception("Failed to fetch reservations");
      }
    } catch (error) {
      print("error is :::$error");
      throw Exception("Failed to fetch reservations");
    }
  }

  Future<void> cancelReservation(String reservationId,String customer,String status) async {
    final Map<String, dynamic> requestBody = {
      "restaurant": widget.name,
      "user": customer,
      "reservationId": reservationId,
      "status": status,
    };
    print("before cancellataion");
    print(requestBody);
    try {
      final response = await http.post(
        Uri.parse(
            "https://sparkling-sarong-bass.cyclic.app/signin/restaurant/cancel"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Reservation canceled successfully, you might want to update UI or show a message.
        print("Reservation updated successfully");

      } else {
        // Handle errors based on the response status code
        print("Error: ${response.statusCode}");
        print("Error response: ${response.body}");
      }
    } catch (error) {
      // Handle other errors such as network issues
      print("Error: $error");
    }
  }

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDateTime =
    DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("index is::${index}");
    if (index == 0) {
      // Navigate to Menu screen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Profile(name: widget.name, token: widget.token)),
      );
    } else if (index == 1) {
      // Navigate to Reservations screen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => menu(name: widget.name, token: widget.token)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
          backgroundColor: const Color(0xFF020403),
          title: const Text("Reservations"),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: _onRefresh,
          header: const WaterDropHeader(
            waterDropColor: Colors.teal,
          ),
          child: FutureBuilder<Map<String, dynamic>>(
            future: _reservation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
<<<<<<< HEAD
                return  Center(child: BlurryContainer(
                  blur: 10,
                  color: Colors.white.withOpacity(0.1),
                  elevation: 20,
                  height: 50,
                  width: 50,
                  child: const CircularProgressIndicator(
                    color: Colors.teal,
                  ),
=======
                return const Center(child: CircularProgressIndicator(
>>>>>>> origin/master
                ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Container(
                    child: const Text(
                      "No reservations...",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                // Extract the 'reservations' map
                final reservations = snapshot.data!['reservations'];
                print("reservation length is:::$reservations.length");

                final reservationList = reservations.entries.toList();

                return Center(
                  child: SizedBox(
<<<<<<< HEAD
                    height: height * 0.5,
=======
                    height: height * 0.4,
>>>>>>> origin/master
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        final entry = reservationList[index];
                        final reservation = entry.value;
                        if (kDebugMode) {
                          print("entry=$entry");
                        }
                        if (kDebugMode) {
                          print("reservations after entry=$reservation");
                        }
                        final tempmenu = reservation['menu'];
                        if (kDebugMode) {
                          print(tempmenu);
                        }

                        final formattedMenu = tempmenu.toString().replaceAll(RegExp(r'[\{\}]'), '');
                        if (kDebugMode) {
                          print(formattedMenu);
                        }

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(17, 5, 7, 5),
                          child: Container(
<<<<<<< HEAD
                            // height: height * 1.3,
                            width: width * 0.90,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
=======
                            height: height * 1.3,
                            width: width * 0.90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.4),
>>>>>>> origin/master
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
<<<<<<< HEAD
                              shape:  const RoundedRectangleBorder(
                                borderRadius:  BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30)),

                              ),
                              color: const Color.fromRGBO(
                                  40, 28, 45, 1.0),
=======
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              // color: const Color(0xFF292929),
                                color: Colors.purple.shade900,
>>>>>>> origin/master
                              shadowColor: Colors.black.withOpacity(0.6),
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 9.0, left: 1, right: 1),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
<<<<<<< HEAD
                                              left: 8.0, right: 8,top: 3),
=======
                                              right: 120.0, left: 0.0),
                                          child: Text(
                                            "Reservation=${index + 1}",
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
>>>>>>> origin/master
                                          child: Text(
                                            "Status: ${reservation['status']}",
                                            style: TextStyle(
                                                color: reservation['status'] ==
                                                    "Active"
                                                    ? Colors.green
<<<<<<< HEAD
                                                    : Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 60.0,right: 20,top: 3),
                                          child: Text(
                                            "Payment:${reservation['paymentstatus']}",
                                            style: TextStyle(
                                                color: reservation[
                                                'paymentstatus'] ==
                                                    "Pending"
                                                    ? Colors.red
                                                    : Colors.green,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,),
=======
                                                    : Colors.red),
>>>>>>> origin/master
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      indent: 8,
                                      endIndent: 8,
                                      color: Colors.white70,
                                      thickness: 2,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              "Customer=${reservation['customername']}",
<<<<<<< HEAD
                                              style: const TextStyle(color: Colors.white,fontSize: 15,
                                                fontWeight: FontWeight.w700,),
                                            ),
                                          ),

=======
                                              style: const TextStyle(color: Colors.white,),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 80.0),
                                            child: Text(
                                              "Payment=${reservation['paymentstatus']}",
                                              style: TextStyle(
                                            color: reservation[
                                            'paymentstatus'] ==
                                            "Pending"
                                            ? Colors.red
                                                : Colors.green),
                                            ),
                                          ),
>>>>>>> origin/master
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      indent: 8,
                                      endIndent: 8,
                                      color: Colors.white70,
                                      thickness: 2,
                                    ),
<<<<<<< HEAD
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 115.0, left: 0.0),
                                            child: Text(
                                              "Creation time: ${_formatTimestamp(entry.key)}",
                                              style:
                                              const TextStyle(color: Colors.white,fontSize: 15,
                                                fontWeight: FontWeight.w700,),
                                            ),
                                          ),
                                        ],
                                      ),
=======
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 115.0, left: 0.0),
                                          child: Text(
                                            "Creation time: ${_formatTimestamp(entry.key)}",
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
>>>>>>> origin/master
                                    ),
                                    const Divider(
                                      indent: 8,
                                      endIndent: 8,
                                      color: Colors.white70,
                                      thickness: 2,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 90),
                                            child: Text(
                                              "Reservation details:${reservation['reservation_details']}",
                                              maxLines: 5,
<<<<<<< HEAD
                                              style: TextStyle(color: Colors.white,fontSize: 15,
                                                fontWeight: FontWeight.w700,),
=======
                                              style: TextStyle(color: Colors.white),
>>>>>>> origin/master
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      indent: 8,
                                      endIndent: 8,
                                      color: Colors.white70,
                                      thickness: 2,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 5, right: 100.0),
                                            child: Text(
<<<<<<< HEAD
                                              "Menu:$formattedMenu",
                                              style: TextStyle(color: Colors.white,fontSize: 15,
                                                fontWeight: FontWeight.w700,),
=======
                                              "Menu=$formattedMenu",
                                              style: TextStyle(color: Colors.white),
>>>>>>> origin/master
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Stack(
                                      children:[
                                        Container(
<<<<<<< HEAD
                                          decoration:const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(24),
                                            ),
                                            // color: Colors.deepPurple.shade900.withOpacity(0.2)
                                            color: Color.fromRGBO(
                                                87, 90, 94, 1.0),
=======
                                          decoration:  const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(24),
                                                bottomRight: Radius.circular(24)),
                                            // color: Color.fromRGBO(90, 90, 90, 0.9),
                                            color: Colors.deepPurple,
>>>>>>> origin/master
                                          ),
                                          height: 70,
                                          width: double.maxFinite,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 9,left: 120,bottom: 7),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.black,
                                                elevation: 100,
                                                shadowColor: Colors.black,
                                                backgroundColor: Colors.red,
                                                fixedSize: const Size(110, 40),
<<<<<<< HEAD
                                                shape:const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(12),),
                                                ),
=======
                                                shape: const StadiumBorder(),
>>>>>>> origin/master
                                                padding: const EdgeInsets.only(
                                                    left: 3),
                                              ),
                                              onPressed: () async {
                                                await cancelReservation(
                                                    reservationIds[index],
                                                    reservation['restaurant'],
                                                    "cancel");
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
<<<<<<< HEAD
                return const Center(child: BlurryContainer(
                  width: 90,
                  elevation: 10,
                  child: Text("No reservations available."),),);
=======
                return const Center(child: Text("No reservations available."));
>>>>>>> origin/master
              }
            },
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
              icon: Icon(Icons.menu_book_rounded),
              label: 'menu',
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
}
