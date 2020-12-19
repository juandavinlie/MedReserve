import 'package:flutter/material.dart';
import 'package:medreserve/models/hospital.dart';
import 'package:medreserve/models/localhospital.dart';
import 'package:medreserve/screens/authenticate/authenticate.dart';
import 'package:medreserve/screens/pages/home.dart';
import 'package:medreserve/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {

    final hospital = Provider.of<Hospital>(context);

    return hospital != null 
      ? StreamProvider<LocalHospital>.value(
        value: DatabaseService(hospitalId: hospital.uniqueId).localHospital,
        child: Home()
      ) 
      : Authenticate();
  }
}