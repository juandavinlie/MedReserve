import 'package:flutter/material.dart';
import 'package:medreserve/models/applicant.dart';
import 'package:medreserve/screens/loading.dart';
import 'package:medreserve/screens/pages/accepted_card.dart';
import 'package:medreserve/screens/pages/applicant_card.dart';
import 'package:provider/provider.dart';

class ApplicantList extends StatefulWidget {

  bool accepted;

  ApplicantList({ this.accepted });

  @override
  _ApplicantListState createState() => _ApplicantListState();
}

class _ApplicantListState extends State<ApplicantList> {
  @override
  Widget build(BuildContext context) {

    final applicants = Provider.of<List<Applicant>>(context);

    return applicants == null 
      ? Loading() 
      : applicants.length == 0
        ? Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text("No Applicants yet"),
        )
        : ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: applicants.length,
        itemBuilder: (context, index) {
          return widget.accepted ? AcceptedCard(applicant: applicants[index]) : ApplicantCard(applicant: applicants[index]);
        },
      );
  }
}