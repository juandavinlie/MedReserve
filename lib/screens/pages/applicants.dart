import 'package:flutter/material.dart';
import 'package:medreserve/models/applicant.dart';
import 'package:medreserve/models/hospital.dart';
import 'package:medreserve/screens/pages/applicant_list.dart';
import 'package:medreserve/services/database.dart';
import 'package:provider/provider.dart';

class Applicants extends StatefulWidget {
  @override
  _ApplicantsState createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  @override
  Widget build(BuildContext context) {

    final hospital = Provider.of<Hospital>(context);

    return StreamProvider<List<Applicant>>.value(
      value: DatabaseService(hospitalId: hospital.uniqueId).applicants,
      child: Scaffold(
        body: ApplicantList(accepted: false)
      )
    );
  }
}