// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllSliderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All slider'),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.add))],
      ),
      
      
    );
  }
}