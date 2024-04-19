import 'package:flutter/material.dart';

class search_bar extends StatelessWidget {
  const search_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(left: 10 , right: 10),
        //alignment: Alignment.bottomRight,
        width: MediaQuery.of(context).size.width * 0.4,
        //height: 20,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          decoration: InputDecoration(
            //label: Container(),
            icon: Icon(Icons.search),
            labelText: "Search for products, brands and more",
            border: InputBorder.none,
          ),
        )
      ),
    );
  }
}
