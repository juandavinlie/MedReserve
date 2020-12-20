import 'package:flutter/material.dart';
import 'package:medreserve/models/applicant.dart';
import 'package:medreserve/models/hospital.dart';
import 'package:medreserve/services/database.dart';
import 'package:provider/provider.dart';

class AcceptedCard extends StatefulWidget {
  final Applicant applicant;
  AcceptedCard({this.applicant});

  @override
  _AcceptedCardState createState() => _AcceptedCardState();
}

class _AcceptedCardState extends State<AcceptedCard> {
  double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final hospital = Provider.of<Hospital>(context);

    return Card(
        color: widget.applicant.covidPositive ? Colors.red : Colors.green,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(7, 12, 7, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Name: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.applicant.name),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text("Age: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.applicant.age.toString())
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text("Gender: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.applicant.gender)
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text("Phone Number: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.applicant.phoneNumber.toString())
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text("Email: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.applicant.email)
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Symptoms: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      widget.applicant.symptoms.toString().substring(
                          1, widget.applicant.symptoms.toString().length - 1),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () async {
                    await DatabaseService(hospitalId: hospital.uniqueId)
                        .deleteApplicantFromAccepted(widget.applicant);
                  },
                  alignment: Alignment.topRight,
                  icon: Icon(Icons.delete),
                ),
              )
            ],
          ),
        )
      );
  }
}
