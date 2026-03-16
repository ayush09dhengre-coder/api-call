import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:profiledata/screens/edit_main_file.dart';
import 'package:profiledata/screens/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController numberController = TextEditingController();
  // final TextEditingController genderController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  var mydecode = [];
  void getApi() async {
    var url = Uri.https(
      "akashsir.in",
      "myapi/crud/student-list-api.php",
    );
    try {
      var response = await http.get(url);
      var decodedData = json.decode(response.body);
      mydecode = decodedData['student_list'];
      setState(() {
        mydecode;
      });
      print(mydecode);
    } catch (e) {
      print("Error occur ${e}");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: mydecode.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue
                      ),
                      height: 170,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Student Id: ${mydecode[index]['st_id'].toString()}"),
                          Text("Student Name: ${mydecode[index]['st_name'].toString()}"),
                          Text("Student Gender: ${mydecode[index]['st_gender'].toString()}"),
                          Text("Student Email: ${mydecode[index]['st_email'].toString()}"),
                          Row(
                            children: [
                              Text("Student Number: ${mydecode[index]['st_mobileno'].toString()}"),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  var selectedStudent = mydecode[index];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditMainFile(
                                        idPath: selectedStudent['st_id'].toString(),
                                        namePath: selectedStudent['st_name'].toString(),
                                        emailPath: selectedStudent['st_gender'].toString(),
                                        genderPath: selectedStudent['st_email'].toString(),
                                        numberPath: selectedStudent['st_mobileno'].toString(),
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  getApi();
                },
                child: Text(
                  "Call api",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
