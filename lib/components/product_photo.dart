import 'package:flutter/material.dart';
import 'package:sohil_jd/shared/ui_helper.dart';


class ProductPhoto extends StatefulWidget {
  List<String> images;
  ProductPhoto(this.images);
  @override
  _ProductPhotoState createState() => _ProductPhotoState();
}

class _ProductPhotoState extends State<ProductPhoto> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // WooProduct product = Provider.of<WooProduct>(context);

    return widget.images.length > 0
        ? Column(
      children: <Widget>[
        SizedBox(
          height: screenHeight(context) * 0.45,
          width: screenWidth(context),
          child: PageView.builder(
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Container(

                  // padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),
        SizedBox(
            height: screenHeight(context) * 0.15,
            width: screenWidth(context) ,
            child:
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: widget.images.length,
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        margin: EdgeInsets.all(2.5),
                        height: 80,
                        duration: Duration(milliseconds: 200),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _pageController.animateToPage(index,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            });
                          },
                          child: ClipRRect(
                              borderRadius: roundedCorner(4),
                              child: Image.network(
                                widget.images[index],
                                fit: BoxFit.cover,
                              )),
                        ),
                      );
                    }),
                ),


      ],
    )
        : Container(
      child: Text('Images not Provided'),
    );
  }
}
