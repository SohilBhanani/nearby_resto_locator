import 'package:flutter/material.dart';
import 'package:sohil_jd/shared/ui_helper.dart';

class MenuCard extends StatelessWidget {
  final String name;
  final String cuisine;
  final double rating;
  final String category;
  final double price;
  final String image;

  MenuCard({this.name,this.cuisine,this.rating,this.category,this.price,this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 90,
              width: 90,
              child: ClipRRect(
                  borderRadius: roundedCorner(8),
                  child: Image.network(image,fit: BoxFit.cover,)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                        // fit: BoxFit.contain,
                        child: Text(name,style: tx16,maxLines: 2,)),
                  ],
                ),
                Text(cuisine,style: tx14.apply(fontStyle: FontStyle.italic),),
                Text("\$ "+price.toString(),style: tx16.copyWith(fontWeight: FontWeight.normal),),
                Container(
                  color: category.startsWith('P')?Colors.green:Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(left:4.0,right: 4.0),
                    child: Text(category.toUpperCase(),style: txColor(Colors.white),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
