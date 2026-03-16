import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.idPath,
  });
  final idPath;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  void ApiCall() async {
    var url = Uri.https("akashsir.in", "myapi/crud/student-change-password-api.php"); //https://akashsir.in/myapi/crud/
    var response = await http.post(
        url,
        body: {
          "st_id": idController.text,
          "opass": oldPasswordController.text,
          "npass": newPasswordController.text,
          "cpass": confirmPasswordController.text,
        }
    );
    setState(() {
      mydata = response.body;
    });
  }
  var mydata = "";

  @override
  void initState() {
    super.initState();
    idController.value = TextEditingValue(text: widget.idPath[0]['st_id'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(fontSize: 30),),
                Container(
                  height: 80,
                  width: 180,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue
                  ),
                  child: ListView.builder(
                    itemCount: widget.idPath.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("Student id: ${widget.idPath[index]['st_id']}"),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: idController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Counter value";
                    } return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    // labelText: 'Student Id',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ), // id
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: oldPasswordController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Counter value";
                    } if(value.length < 5) {
                      return "old Password can not be of 5 letters";
                    } return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Old password',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ), //old password
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: newPasswordController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Counter value";
                    } if(value.length < 5) {
                      return "old Password can not be of 5 letters";
                    } return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'New password',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ), // new password
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Counter value";
                    } if(value.length < 5) {
                      return "Enter new password";
                    } if(newPasswordController.text != confirmPasswordController.text) {
                      return "Pass don't match";
                    } return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ), // confirm password
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if(!_formKey.currentState!.validate()) {
                        return;
                      } else {
                        ApiCall();
                        // idController.value = TextEditingValue(text: widget.idPath[0]['st_id'].toString());
                      }
                    },
                    child: const Text('Change Password',style: TextStyle(fontSize: 22),),
                  ),
                ),
                Text(
                  mydata,
                  style: TextStyle(fontSize: 21),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
