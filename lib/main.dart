import 'package:flutter/material.dart';
import 'package:medreserve/screens/wrapper.dart';
import 'package:medreserve/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/hospital.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Hospital>.value(
          value: AuthService().hospital,
          child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Wrapper(),
          },
        ),
      );
    }
}
