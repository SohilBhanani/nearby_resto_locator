import 'package:flutter/material.dart';
import 'package:sohil_jd/components/cart_dialog.dart';
import 'package:sohil_jd/components/product_photo.dart';
import 'package:sohil_jd/shared/colors.dart';
import 'package:sohil_jd/shared/ui_helper.dart';

class ItemScreen extends StatelessWidget {
  var item;
  var resto;

  ItemScreen({this.item, this.resto});
  String desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  @override
  Widget build(BuildContext context) {
    List<String> imgs = List<String>.generate(
        item['images'].length, (index) => item['images'][index]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item['name'],
        ),

      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductPhoto(imgs),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  color: item['category'].startsWith('P')
                      ? Colors.green
                      : Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Text(
                      item['category'].toUpperCase(),
                      style: txColor(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                item['name'],
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 26),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Text(
                    'Ratings: ',
                    style: txColor(Colors.black38)
                        .apply(fontStyle: FontStyle.italic),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    height: 20,
                    width: 30,
                    color: Colors.green,
                    child: Center(child: Text(item['rating'].toString())),
                  ),
                ],
              ),
            ),
            verticalSpaceSmall,
            pickupText(item['category']),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return CartDialog(resto:resto,item:item,sameDayPickup: item['category']=="Same Day Pickup"?true:false,);
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "ADD TO CART",
                        style: txColor(kPrim).copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(desc,textAlign: TextAlign.justify,),
            )
          ],
        ),
      ),
    );
  }

  Widget pickupText(String category) {
    if (category.compareTo("Same Day Pickup") == 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          "Pickup available from ${myToDate(resto['timeFrom'])} to ${myToDate(resto['timeTo'])}",
          style:
              tx16.copyWith(fontWeight: FontWeight.normal, color: Colors.grey),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Available for ${resto['days']} ",
                style: tx16.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.grey)),
            Text(
              "Pickup available ${myToDate(resto['timeFrom'])} to ${myToDate(resto['timeTo'])}",
              style: tx16.copyWith(
                  fontWeight: FontWeight.normal, color: Colors.grey),
            ),
          ],
        ),
      );
    }
  }
}
