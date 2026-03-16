import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditMainFile extends StatefulWidget {
  const EditMainFile({
    super.key,
    required this.idPath,
    required this.namePath,
    required this.emailPath,
    required this.genderPath,
    required this.numberPath,
  });

  final idPath;
  final namePath;
  final emailPath;
  final genderPath;
  final numberPath;

  @override
  State<EditMainFile> createState() => _EditMainFileState();
}

class _EditMainFileState extends State<EditMainFile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  void apiCall() async {
    var url = Uri.https(
      "akashsir.in",
      "myapi/crud/student-update-api.php",
    );
    try {
      var response = await http.post(
        url,
        body: {
          "st_id": idController.text,
          "st_name": nameController.text,
          "st_gender": genderController.text,
          "st_email": emailController.text,
          "st_mobileno": numberController.text,
        },
      );
      var decodedata = jsonDecode(response.body);
      myData = decodedata;
      setState(() {
        myData;
      });
    } catch (e) {
      print("Error occur ${e}");
    }
  } // update

  var myData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idController.text = widget.idPath;
    nameController.text = widget.namePath;
    emailController.text = widget.emailPath;
    genderController.text = widget.genderPath;
    numberController.text = widget.numberPath;
  }

  String? validId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? validName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    if (value.length < 4) {
      return 'name must be greater then 4 leters';
    }
    return null;
  }

  String? validEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Email';
    }
    if (value.length < 4) {
      return 'name must be greater then 4 leters';
    }
    return null;
  }

  String? validType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Gender';
    }
    return null;
  }

  String? validNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    if (value.length < 10) {
      return 'number must be of 10 digit';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Edit Student profile",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: idController,
              decoration: InputDecoration(
                labelText: 'Enter id',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: validId,
            ), // id
            SizedBox(height: 20),

            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: validName,
            ), // name
            SizedBox(height: 20),

            TextFormField(
              controller: genderController,
              decoration: InputDecoration(
                labelText: 'Enter Gender',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: validType,
            ), // gender
            SizedBox(height: 20),

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: validEmail,
            ), // email
            SizedBox(height: 20),

            TextFormField(
              controller: numberController,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: validNumber,
            ), // number

            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                } else {
                  apiCall();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 4,
                padding: EdgeInsets.all(10),
              ),
              child: Text("Update profile", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
