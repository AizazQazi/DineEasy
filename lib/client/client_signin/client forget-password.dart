import 'dart:convert';
import 'package:dine_easy/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:http/http.dart' as http;
import './loginpg.dart';


class forgetpassword extends StatefulWidget {
  const forgetpassword({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return forgetpasswordstate();
  }
}

// ignore: camel_case_types
class forgetpasswordstate extends State<forgetpassword> {
  //function for forget password up
  forget(BuildContext context) async {
    final String email = useremail.text.trim();
    if (kDebugMode) {
      print("Email before sending: $email");
    }
    if (_formKey.currentState!.validate()) {
      final Map<String, String> data = {
        "email": email,
      };
      if (kDebugMode) {
        print("data before signing up is=$data");
      }

      final response = await http.post(
        Uri.parse("https://sparkling-sarong-bass.cyclic.app/signin/restaurant/forgot-password"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final token = jsonResponse['token'];
        if (kDebugMode) {
          print(token);
        }
        Fluttertoast.showToast(
          msg: "Password reset successfully!Please follow email link.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        Fluttertoast.showToast(
          msg: "Invalid email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      return 'please fill all fields';
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController useremail = TextEditingController();
  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed to prevent memory leaks
    useremail.dispose();
    super.dispose();
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
          title: const Text("Reset Password"),
          backgroundColor: const Color(0xFF020403),
        ),
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Enter your email.Link will be sent to reset the password",
                        style: TextStyle(color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.italic),
                      ),
<<<<<<< HEAD
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: BlurryContainer(
                          blur: 8,
                          width: width * 0.80,
                          color: Colors.white.withOpacity(0.2),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30)),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    controller: useremail,
                                    style:
                                    const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.email_outlined,
                                        color: Colors.white,
                                      ),
                                      labelText: 'email',
                                      hintText: 'Enter your email',
                                      labelStyle:
                                      TextStyle(color: Colors.white),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter email';
                                      }
                                      return null;
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      ElevatedButton(
                                        onPressed: () => forget(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black12,
                                          surfaceTintColor: Colors.deepOrange,
                                          elevation: 20,
                                          shape: RoundedRectangleBorder(
                                            side:const BorderSide(
                                              color: Colors.orange,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                                        ),
                                        child: const Text("Reset password"),
                                      ),
                                    ],
                                  ),
                                ],
=======
                      Center(
                        child: BlurryContainer(
                          blur: 8,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(60)),
                          child: Container(
                            height: height * 0.1,
                            width: width * 0.80,
                            color: Colors.white.withOpacity(0.2),
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: useremail,
                                      style:
                                      const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.email_outlined,
                                          color: Colors.white,
                                        ),
                                        labelText: 'email',
                                        hintText: 'Enter your email',
                                        labelStyle:
                                        TextStyle(color: Colors.white),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
>>>>>>> origin/master
                              ),
                            ),
                          ),
                        ),
                      ),
<<<<<<< HEAD

=======
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          ElevatedButton(
                            onPressed: () => forget(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade500,
                              padding: const EdgeInsets.only(left: 7, right: 4),
                            ),
                            child: const Text("Reset password"),
                          ),
                        ],
                      ),
>>>>>>> origin/master
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
