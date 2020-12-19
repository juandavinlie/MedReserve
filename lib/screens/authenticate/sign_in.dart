import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medreserve/services/auth.dart';
import 'package:uuid/uuid.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.black),
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                // margin: EdgeInsets.fromLTRB(20, 150, 20, 175),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Center(
                        child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Sign In to MedReserve',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Email",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            validator: (val) =>
                                val.isEmpty ? "Enter an email" : null,
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
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
                            child: Text("Sign In"),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = "Your account doesn't exist";
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ))),
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.4,
              height: 0,
              indent: 20,
              endIndent: 20,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: 'Register',
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
            )
          ],
        ),
      ),
    );
  }
}