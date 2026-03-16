import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:profiledata/login_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void ApiCall() async {
    var url = Uri.https("akashsir.in", "myapi/crud/student-add-api.php"); //https://akashsir.in/myapi/crud/
    var response = await http.post(
        url,
        body: {
          "st_name": nameController.text,
          "st_gender": newController.text,
          "st_email": emailController.text,
          "st_mobileno": numberController.text,
          "st_password": passwordController.text,
        }
    );
    setState(() {
      mydata = response.body;
    });
  }
  var mydata = "";

  String? validName(String? value) {
    if(value == null || value.isEmpty) {
      return "Please Enter your name";
    } if(value.length < 4) {
      return "name can not be less then 4 letters";
    } return null;
  }

  String? validType(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "not null";
    }
    final gender = value.trim().toLowerCase();
    final isValidGender =
        gender == 'male' || gender == 'female';
    if (!isValidGender) {
      return "Enter gender";
    }
    return null;
  }

  String? validEmail(String? value) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty) {
      return "Please Enter your email";
    } if(value.length < 5) {
      return "email can not be less then 3 letters";
    } if(!regex.hasMatch(value!)) {
      return "Enter valid email";
    } return null;
  }

  String? validNumber(String? value) {
    if(value!.isEmpty) {
      return "Please enter your number";
    } if(value.length < 10) {
      return "Mobile num must be of 10 digit";
    } return null;
  }

  String? validPassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    } if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
      return "Password must be complex and contain ayu@123";
    } return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          "Signup",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: validName,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: newController,
                  validator:  validType,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: emailController,
                  validator: validEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: numberController,
                  validator: validNumber,
                  decoration: const InputDecoration(
                    labelText: 'MobileNo.',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
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
                    onPressed: () {
                      if(!_formKey.currentState!.validate()) {
                        return;
                      } else {
                        ApiCall();
                        Future.delayed(Duration(seconds: 5),() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },);
                      }
                    },
                    child: const Text('Sign_up',style: TextStyle(fontSize: 22),),
                  ),
                ),

                Text("${mydata}"),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
