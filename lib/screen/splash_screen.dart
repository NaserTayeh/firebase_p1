// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_firebase/auth/auth_helper.dart';
import 'package:flutter_application_firebase/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatelessWidget {
  // navigationFun(BuildContext context)async{
  //   await Future.delayed(const Duration(seconds: 3));
  //   Provider.of<AuthProvider>(context,listen: false).checkUser();
  // }
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).checkUser();
    return Scaffold(
      body: Center(child: FlutterLogo()),
    );
  }
}
