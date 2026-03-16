import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  var mydata1 = [];

  final TextEditingController idController1 = TextEditingController();
  final TextEditingController nameController1 = TextEditingController();
  final TextEditingController emailController1 = TextEditingController();
  final TextEditingController genderController1 = TextEditingController();
  final TextEditingController numberController1 = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController deleteController1 = TextEditingController();


  var getdata = "";
  var demo;
  void ApiCall1() async {
    try {
      var url = Uri.parse("https://akashsir.in/myapi/crud/student-display-api.php");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var fullMap = jsonDecode(response.body);

        setState(() {
          // IMPORTANT: Reach inside the map to get the actual list!
          // Replace 'student_list' with whatever key you see in Postman
          mydata1 = fullMap['student_list'];
        });
      }
    } catch (e) {
      print("Error catching data: $e");
    }
  }

  void delApi(String studentId) async {
    var url = Uri.https("akashsir.in", "myapi/crud/student-delete-api.php");
    var response = await http.post(
        url,
        body: {
          "st_id": studentId,
        }
    );
    setState(() {
      getdata = response.body;
    });
    ApiCall1();
  }

  @override
  void initState() {
    super.initState();
    ApiCall1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Signup',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Student profile",style: TextStyle(fontSize: 32),),
            SizedBox(
              height: 20,
            ),

            Container(
              height: 500,
              width: double.infinity,
              color: Colors.deepPurple,
              child: ListView.builder(
                itemCount: mydata1.length,
                itemBuilder: (context, index) {
                  return Container(
                    // height: 200,
                    width: 300,
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                      color: Colors.blueAccent,
                    ),
                    padding: EdgeInsets.only(left: 10,top: 20,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name: ${mydata1[index]['st_name'].toString()}",
                              style: TextStyle(fontSize: 22),
                              textAlign: TextAlign.left,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child: Icon(Icons.delete,),
                                onTap: () {
                                  String studentId = mydata1[index]["st_id"].toString();
                                  delApi(studentId);
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Gender: ${mydata1[index]['st_gender'].toString()}",
                          style: TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Email: ${mydata1[index]['st_email'].toString()}",
                          style: TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text("Number: ${mydata1[index]['st_mobileno'].toString()}",style: TextStyle(fontSize: 22),),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                getdata,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

