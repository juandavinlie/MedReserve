import 'package:flutter/material.dart';
import 'package:medreserve/models/applicant.dart';
import 'package:medreserve/models/hospital.dart';
import 'package:medreserve/screens/pages/applicant_list.dart';
import 'package:medreserve/services/database.dart';
import 'package:provider/provider.dart';

class Accepted extends StatefulWidget {
  @override
  _AcceptedState createState() => _AcceptedState();
}

class _AcceptedState extends State<Accepted> {
  @override
  Widget build(BuildContext context) {
    final hospital = Provider.of<Hospital>(context);

    return StreamProvider<List<Applicant>>.value(
      value: DatabaseService(hospitalId: hospital.uniqueId).acceptedApplicants,
      child: Scaffold(
        body: ApplicantList(accepted: true,)
      )
    );
  }
}