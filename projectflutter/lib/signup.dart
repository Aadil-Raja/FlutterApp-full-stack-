import 'package:flutter/material.dart';
import 'package:projectflutter/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import to use jsonEncode
import 'package:projectflutter/dashboard.dart';
import 'package:projectflutter/signin.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Future save() async {
    print("Signup button pressed");
    var res = await http.post(
      Uri.parse("http://192.168.2.2:5000/signup"), // Convert to Uri
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{ // Encode the body as JSON
        'email': user.email,
        'password': user.password,
      }),
    );

    print("Response status: ${res.statusCode}");
    print("Response body: ${res.body}");

    if (res.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed')),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  User user = User('', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Carpool',
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: TextFormField(
                  controller: TextEditingController(text: user.email),
                  onChanged: (value) {
                    user.email = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(
                height: 35,
              ),
              Container(
                width: 300,
                child: TextFormField(
                  controller: TextEditingController(text: user.password),
                  onChanged: (value) {
                    user.password = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 55),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        save();
                      }
                    },
                    child: const Text("Done"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                child: Row(
                  children: [
                    Text(
                      "Already have a account ? ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signin()),
                        );
                      },
                      child: Text(
                        "Signin",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
