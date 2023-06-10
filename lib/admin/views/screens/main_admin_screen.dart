// ignore_for_file: prefer_const_constructors, unnecessary_import, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/admin/views/screens/display_categories.dart';
import 'package:flutter_application_firebase/app_router/app_router.dart';

class MainAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('go To categories'),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text('go To Sliders'),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
