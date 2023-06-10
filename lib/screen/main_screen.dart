// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_firebase/provider/auth_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Consumer<AuthProvider>(builder: ((context, provider, w) {
        return Container(
          color: Colors.grey.withOpacity(0.2),
          child: provider.loggedUser == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        provider.uploadNewFile();
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey,
                        child: Center(
                            child: provider.loggedUser!.imageUrl == null
                                ? Icon(Icons.camera)
                                : Image.network(
                                    (provider.loggedUser?.imageUrl)!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.fill)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfileWidget(
                      label: 'user name',
                      value: provider.loggedUser!.userName,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomProfileWidget(
                      label: 'user email',
                      value: provider.loggedUser!.email,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomProfileWidget(
                      label: 'user phone',
                      value: provider.loggedUser!.phoneNumer,
                    ),
                  ],
                ),
        );
      })),
    );
  }
}

class CustomProfileWidget extends StatelessWidget {
  String label;
  String value;
  CustomProfileWidget({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
                child: Text(
              label,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            Expanded(
                flex: 2,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ));
  }
}
