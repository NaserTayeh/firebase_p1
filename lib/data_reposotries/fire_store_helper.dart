// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_firebase/admin/models/category.dart';
import 'package:flutter_application_firebase/model/user_model.dart';

import '../admin/models/product.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  addNewUSer(AppUser appUser) async {
    firestore.collection('USERSS').doc(appUser.id).set(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection('USERSS').doc(id).get();
    Map<String, dynamic>? data = documentSnapshot.data();
    AppUser appUser = AppUser.fromMap(data!);
    return appUser;
  }

  updateTheUser(AppUser appUser) async {
    await firestore
        .collection('USERSS')
        .doc(appUser.id)
        .update(appUser.toMap());
  }

  // below here is the admin methods
  Future<String?> addNewCategory(Category category) async {
    try {
      DocumentReference<Map<String, dynamic>> categoryDocument =
          await firestore.collection('categories').add(category.toMap());
      return categoryDocument.id;
    } on Exception catch (e) {
      log(e.toString());
      // TODO
    }
  }

  Future<bool> deleteCategory(String catId) async {
    try {
      log('id in delete' + catId);
      await firestore.collection('categories').doc(catId).delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
      // TODO
    }
  }

  Future<List<Category>?> getAllCategoried() async {
    try {
      QuerySnapshot<Map<String, dynamic>> catsSnapshot =
          await firestore.collection('categories').get();
      List<Category> categories = catsSnapshot.docs.map((doc) {
        Category category = Category.fromMap(doc.data());
        category.id = doc.id;
        return category;
      }).toList();
      return categories;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool?> updateCategory(Category category) async {
    try {
      await firestore
          .collection('categories')
          .doc(category.id)
          .update(category.toMap());
      return true;
    } on Exception catch (e) {
      return false;
      // TODO
    }
  }

  // product function
  Future<String?> addNewProduct(Product product) async {
    DocumentReference<Map<String, dynamic>> documentReference = await firestore
        .collection('categories')
        .doc(product.catId)
        .collection('products')
        .add(product.toMap());
    return documentReference.id;
  }

  Future<List<Product>?> getAllProduct(String catID) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('categories')
        .doc(catID)
        .collection('products')
        .get();

    return querySnapshot.docs.map((e) {
      Product product = Product.fromMap(e.data());
      product.id = e.id;
      return product;
    }).toList();
  }

  Future<bool?> deleteProduct() async {}
  Future<bool?> updateProduct() async {}
}
