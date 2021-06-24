import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sohil_jd/components/menu_card.dart';
import 'package:sohil_jd/screens/item_screen.dart';
import 'package:sohil_jd/services/database_service.dart';

class MenuScreen extends StatelessWidget {
  var resto;

  MenuScreen({this.resto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: FutureBuilder(
        future: Provider.of<DatabaseService>(context).getRestoMenu(resto['restoid']),
        builder: (context, snapshot) {
          return snapshot.hasData? ListView.separated(
            itemBuilder: (context, i) {
                var menuItem = snapshot.data.docs[i].data();
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemScreen(item:menuItem,resto: resto)));
                  },
                  child: MenuCard(
                    name: menuItem['name'],
                    price: menuItem['price'],
                    rating: menuItem['rating'],
                    cuisine: menuItem['cuisine'],
                    category: menuItem['category'],
                    image: menuItem['images'][0],
                  ),
                );

            },
            itemCount: snapshot.data.docs.length, separatorBuilder: (BuildContext context, int index) { return Divider(); },
          ): Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
