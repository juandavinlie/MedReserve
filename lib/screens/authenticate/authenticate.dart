import 'package:flutter/material.dart';
import 'package:medreserve/screens/authenticate/register.dart';
import 'package:medreserve/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool _isRegistered = true;

  void toggleView() {
    setState(() {
      _isRegistered = !_isRegistered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isRegistered ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}