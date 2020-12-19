import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:medreserve/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  int capacity;
  String error = '';

  bool parsable(String input) {
    try {
      int intVersion = int.parse(input);
      print(intVersion);
      return true;
    } catch(e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[50],
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Register to MedReserve', style: TextStyle(fontSize: 20),),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (val) => val.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Hospital Name"),
                      validator: (val) =>
                          val.isEmpty ? "Enter a name" : null,
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Capacity"),
                      keyboardType: TextInputType.number,
                      validator: (val) => !parsable(val)
                          ? "Enter only number for capacity"
                          : int.parse(val) < 0
                            ? "Enter a positive number for capacity"
                            : null,
                      onChanged: (val) {
                        capacity = int.parse(val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (val) => val.length < 6
                          ? "Enter a password of at least 6 characters long"
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      child: Text("Register"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(email,
                                  password, name, capacity);
                          if (result == null) {
                            setState(() {
                              error = "Please supply a valid email";
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: 'Sign In',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.toggleView();
                            })
                    ])),
                    SizedBox(height: 12.0),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}