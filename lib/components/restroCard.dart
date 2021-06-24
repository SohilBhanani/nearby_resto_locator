import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sohil_jd/shared/ui_helper.dart';

class RestroCard extends StatelessWidget {
  final String name;
  final int proximity;
  final rating;
  RestroCard({this.rating,this.name,this.proximity});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  verticalSpaceTiny,
                  Text("Cuisine: Vegan | Andhra (dummy)",style: TextStyle(fontStyle: FontStyle.italic),),
                  verticalSpaceTiny,
                  Text("near india gate - Delhi (dummy)"),
                  // verticalSpaceTiny,
                  Text(proximity.toString()+" minutes from your location",style: TextStyle(color: Colors.grey,fontSize: 12),)
                ],
              ),
            ),
            Container(
              height: 20,
              width: 25,
              color: Colors.green,
              child: Center(
                child: Text(
                  rating.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
