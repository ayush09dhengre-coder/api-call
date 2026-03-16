import 'package:flutter/material.dart';
import 'package:profiledata/screens/edit_profile.dart';
import 'package:profiledata/screens/home_screen.dart';
import 'package:profiledata/screens/students.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.dataPath,
  });
  final dataPath;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student profile",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xCA192577),
                            Color(0xAE131839),
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 40,left: 10,right: 10),
                      padding: EdgeInsets.only(top: 40),
                      child: ListView.builder(
                        itemCount: widget.dataPath.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "Student Id: ${widget.dataPath[index]['st_id'].toString()}",
                              style: TextStyle(fontSize: 23),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Student Name: ${widget.dataPath[index]['st_name'].toString()}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                  ),
                                ),
                                Text(
                                  "Student gender: ${widget.dataPath[index]['st_gender'].toString()}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white
                                  ),
                                ),
                                Text(
                                  "Student email: ${widget.dataPath[index]['st_email'].toString()}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Student number: ${widget.dataPath[index]['st_mobileno'].toString()}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 140,
                                    top: 10,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      elevation: 4,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditProfile(
                                            idPath: widget.dataPath.isEmpty ? [] : widget.dataPath,
                                            namePath: widget.dataPath.isEmpty ? [] : widget.dataPath,
                                            emailPath: widget.dataPath.isEmpty ? [] : widget.dataPath,
                                            genderPath: widget.dataPath.isEmpty ? [] : widget.dataPath,
                                            numberPath: widget.dataPath.isEmpty ? [] : widget.dataPath,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text("Edit profile"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 95),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        elevation: 4
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                            idPath: widget.dataPath.isEmpty ? [] : widget.dataPath,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "change password",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Students()));
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 30,right: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white12,
                      width: 2,
                    ),
                    // color: Colors.blue,
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.blue
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Text(
                    "All Student profile",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
