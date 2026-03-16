import 'package:flutter/material.dart';

import 'login_page.dart';
import 'signup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.namePath,
    required this.newPath,
    required this.emailPath,
    required this.numberPath,
  });
  final namePath;
  final newPath;
  final emailPath;
  final numberPath;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                width: 200,
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.person),
                    Text(
                      "Add Student",
                      style: TextStyle(
                        fontSize: 22
                      ),
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),),);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                width: 200,
                margin: EdgeInsets.only(left: 20,right: 20, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.person),
                    Text(
                      "New Student",
                      style: TextStyle(
                          fontSize: 22
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text("${widget.namePath}",),
            Text("${widget.emailPath}",),
            Text("${widget.newPath}",),
            Text("${widget.numberPath}",),

          ],
        ),
      ),
    );
  }
}

