// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/admin/views/screens/add_category.dart';
import 'package:provider/provider.dart';

import '../../../app_router/app_router.dart';
import '../../provider/admin_provider.dart';
import '../component/category_widget.dart';

class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(AddNewCategory());
              },
              icon: Icon(Icons.add))
        ],
        title: Text('All Categories'),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allCategories == null
            ? Center(
                child: Text('No Categories Found'),
              )
            : ListView.builder(
                itemCount: provider.allCategories!.length,
                itemBuilder: (context, index) {
                  return CategoryWidget(provider.allCategories![index]);
                });
      }),
    );
  }
}
