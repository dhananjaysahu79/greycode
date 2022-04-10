import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  final child;
  const Popup({ 
    Key? key , 
    this.child 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      clipBehavior: Clip.antiAlias,
       decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if(child != null) child
        ],
      ),
    );
  }
}