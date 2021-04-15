



import 'package:flutter/material.dart';

class ListImageWidget extends StatelessWidget {
 String imageUrl;
 String id;


 ListImageWidget({this.imageUrl="", this.id=""});

  @override
  Widget build(BuildContext context) {



    return Container(

      width: double.infinity,
      child: Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Image.network(imageUrl,fit: BoxFit.fill,)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text("Product ID : ${id}"),
          )
        ],
      ),
    ),);
  }
}
