import 'package:checkpoint/widgets/details_header.dart';
import 'package:checkpoint/widgets/records.dart';
import 'package:checkpoint/widgets/summary.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(32),
        ),
      ),
      margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        children: <Widget>[
          DetailsHeader(),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Records(),
              ),
              Expanded(
                child: Summary(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
