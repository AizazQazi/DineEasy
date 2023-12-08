import 'dart:convert';
import './signup.dart';
import '../token_manager.dart';
import '../profile/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:http/http.dart' as http;
import './Forget-password.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Home_2 extends StatefulWidget {
   const Home_2({Key? key}) : super(key: key);
  //  final String name;
  // final dynamic token;
  @override
  State<StatefulWidget> createState() {
    return Home_2state();
  }
}

// ignore: camel_case_types
class Home_2state extends State<Home_2> {
  bool isPasswordVisible = false;
  bool isloading=false;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();


  login(BuildContext context) async {

    // setState(() {
    //   isloading=true;
    // });

    final String email = useremail.text.trim();
    final String password=userpassword.text;
    final String name=username.text;
    if (kDebugMode) {
      print("Email before sending: $email");
    }
    if (_formKey.currentState!.validate()) {
      final Map<String, String> data = {
        "name":name,
        "email":email, // Replace with your email
        "password":password // Replace with your password
      };
        final response = await http.post(
          Uri.parse("https://sparkling-sarong-bass.cyclic.app/signin/restaurant"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        );
      if (kDebugMode) {
        print("req sent");
      }if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final token = jsonResponse['token'];
        if (kDebugMode) {
          print(token);
        }
        // await Future.delayed(const Duration(seconds: 1));
        // setState(() {
        //   isloading=false;
        // });
        // Use the token or store it for future requests
        Fluttertoast.showToast(
          msg: "Signed in successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        _btnController.success();
        await TokenManager.saveToken(token);
        await TokenManager.saveName(name);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile(name:name , token: token)
        ));
      } else {
        _btnController.error();
        // setState(() {
        //   isloading=false;
        // });
        Fluttertoast.showToast(
          msg: "Invalid email or password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      _btnController.error();
      // setState(() {
      //   isloading=false;
      // });
      return 'please fill all fields';
    }
  }


  final _formKey = GlobalKey<FormState>();
  final TextEditingController useremail=TextEditingController();
  final TextEditingController username=TextEditingController();
  final TextEditingController userpassword=TextEditingController();
  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed to prevent memory leaks
    useremail.dispose();
    username.dispose();
    userpassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(

      decoration:   const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/login.png"),
        fit: BoxFit.fill,),

      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: BlurryContainer(
                width:  width * 0.85,
                blur: 9,
                elevation: 10,
                color: Colors.white.withOpacity(0.15),
<<<<<<< HEAD
                borderRadius: const BorderRadius.all(Radius.circular(30)),
=======
                borderRadius: const BorderRadius.all(Radius.circular(60)),
>>>>>>> origin/master
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        TextFormField(
                          controller: username,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person,color: Colors.white,),
                            labelText: 'Name',
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),

                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'please enter email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: useremail,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email_outlined,color: Colors.white,),
                            labelText: 'email',
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'please enter email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: !isPasswordVisible,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'please enter password';
                            }
                            return null;
                          },
                          controller: userpassword,
                          decoration:  InputDecoration(
                            icon: const Icon(Icons.password,color: Colors.white,),
                            hintText: 'Enter your password',
                            hintStyle: const TextStyle(color: Colors.white),
                            label: const Text('Password'),
                            labelStyle: const TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 158.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const forgetpassword()), // Replace SignUpScreen with the name of your signup screen widget
                              );
                            },
                            child: const Text("Forget password",style: TextStyle(
                              color: Colors.red,
                            ),),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),

                            RoundedLoadingButton(
                              elevation: 20,
                              controller: _btnController,
                              resetAfterDuration: true,
                              // duration: const Duration(seconds: 2),
<<<<<<< HEAD
                              // resetDuration: const Duration(seconds: 4),
                              onPressed: () {
                                login(context);
                                // _btnController.reset();
=======
                              resetDuration: const Duration(seconds: 2),
                              onPressed: () {
                                login(context);
                                _btnController.reset();
>>>>>>> origin/master
                              },
                              child: const Text("Login") ,
                            ),

                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const signup()), // Replace SignUpScreen with the name of your signup screen widget
                            );
                          },
                          child: const Text("Don't have an account, create new",style: TextStyle(
                            color: Colors.red,
                          ),),
                        ),

                      ],
                    ),
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