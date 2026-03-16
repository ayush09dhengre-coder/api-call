import 'package:flutter/material.dart';

class Response extends StatefulWidget {
  const Response({super.key});

  @override
  State<Response> createState() => _ResponseState();
}

class _ResponseState extends State<Response> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          color: Colors.green,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                color: Colors.deepOrange,
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                color: Colors.deepPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
