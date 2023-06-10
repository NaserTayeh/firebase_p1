// ignore: depend_on_referenced_packages
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/app_router/app_router.dart';
import 'package:provider/provider.dart';

import '../../models/category.dart';
import '../../provider/admin_provider.dart';
import '../screens/add_product.dart';
import '../screens/display_product.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget(this.category);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Provider.of<AdminProvider>(context, listen: false)
            .getAllProducts(category.id!);

        AppRouter.appRouter.goToWidget(AllCProductScreen());
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 2)),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(13)),
                      child: SizedBox(
                          width: double.infinity,
                          height: 170,
                          child: Image.network(
                            category.imageUrl,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                        right: 15,
                        top: 10,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    Provider.of<AdminProvider>(context,
                                            listen: false)
                                        .deleteCategory(category);
                                  },
                                  icon: Icon(Icons.delete)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    Provider.of<AdminProvider>(context,
                                            listen: false)
                                        .goToEditCategoryPage(category);
                                  },
                                  icon: Icon(Icons.edit)),
                            ),
                          ],
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Arabic Category' + ': ' + category.nameAr,
                        ),
                        Text(
                          'English Category' + ': ' + category.nameEn,
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        AppRouter.appRouter
                            .goToWidget(AddNewProduct(category.id!));
                      },
                      child: Text('Add Products')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
