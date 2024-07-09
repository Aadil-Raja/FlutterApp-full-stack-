import 'package:flutter/material.dart';
import 'package:projectflutter/user.dart';
import 'package:http/http.dart' as http;
import 'package:projectflutter/dashboard.dart';
import 'package:projectflutter/signup.dart'; // Ensure to import the Signup page
import 'dart:convert'; // Import to use jsonEncode1
class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  Future save() async {
    var res = await http.post(
      Uri.parse("http://192.168.2.2:5000/signin"), // Convert to Uri
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{ // Encode the body as JSON
        'email': user.email,
        'password': user.password,
      }),
    );

    print(res.body);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
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
                    return null; // Add this line to ensure no error when valid
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
                    return null; // Add this line to ensure no error when valid
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
                        // If the form is valid, display a snackbar or perform other actions
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                        );
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
                      "Not have Account ? ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: Text(
                        "Signup",
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
