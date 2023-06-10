// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/admin/views/component/category_widget%20copy.dart';
import 'package:flutter_application_firebase/admin/views/screens/add_category.dart';
import 'package:flutter_application_firebase/data_reposotries/fire_store_helper.dart';
import 'package:provider/provider.dart';

import '../../../app_router/app_router.dart';
import '../../models/product.dart';
import '../../provider/admin_provider.dart';
import '../component/category_widget.dart';

class AllCProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(AddNewCategory());
              },
              icon: Icon(Icons.add))
        ],
        title: Text('All Product'),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        // return Center(
        //   // ignore: deprecated_member_use
        //   child: RaisedButton(onPressed: () async {
        //     List<Product>? products = await FireStoreHelper.fireStoreHelper
        //         .getAllProduct('k2gb5Nay8hO6mwGwaqB0');
        //     log(products?.length.toString() ?? 'not defined');
        //   }),
        // );

        return provider.allProducts == null
            ? Center(
                child: Text('No Product Found'),
              )
            : ListView.builder(
                itemCount: provider.allProducts!.length,
                itemBuilder: (context, index) {
                  return ProductWidget(provider.allProducts![index]);
                });
      }),
    );
  }
}
