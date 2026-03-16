import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:profiledata/screens/profile_screen.dart';
import 'package:profiledata/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var myValue1 = "";
  var myValue2 = "";
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void apiCall() async {
    setState(() {
      _isLoading = true;
    });
    var url = Uri.https("akashsir.in", "myapi/crud/student-login-api.php");
    try{
      var response = await http.post(
        url,
        body: {
          "st_email": emailController.text,
          "st_password": passwordController.text,
        },
      );
      if (response.statusCode == 200) {
        var pref = await SharedPreferences.getInstance();
        await pref.setString("user_json", response.body);
        print("Data Saved!");
        var decodedData = jsonDecode(response.body);
        List decodedList = [];

        if (decodedData is List) {
          decodedList = decodedData;
        } else if (decodedData is Map) {
          decodedList = [decodedData];
        }
        if(mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                dataPath: decodedList,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Success"),),
          );
        }
      } else {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Failed"),),
          );
        }
      }
    } catch (e) {
      print("Error occur ${e}");
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Network Error: $e"),),
        );
      }
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  void getData() async {
    var pref = await SharedPreferences.getInstance();
    String? myData1 = pref.getString("user_json");

    setState(() {
      myValue1 = myData1 ?? "";
    });
  }

  var myData = "";

  String? validName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a email';
    } if(value.length < 4) {
      return 'name must be greater then 4 leters';
    }
    return null;
  }

  String? validPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } if(value.length < 4) {
      return 'name must be greater then 4 leters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.person,size: 30),
          )
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  validator: validName,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: passwordController,
                  validator: validPassword,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isLoading
                    ? null
                    : () {
                      if(!_formKey.currentState!.validate()) return;
                      apiCall();
                    },
                    child: _isLoading
                    ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                    : const Text(
                      "Student Login",
                      style: TextStyle(
                        fontSize: 22
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Don't have account?",
                        style: TextStyle(fontSize: 18,),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Create account",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SvgPicture.asset(
                  "assets/student-svgrepo-com.svg",
                  fit: BoxFit.contain,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

