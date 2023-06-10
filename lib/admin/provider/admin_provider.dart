import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_firebase/admin/models/category.dart';
import 'package:flutter_application_firebase/admin/views/screens/edit_category.dart';
import 'package:flutter_application_firebase/app_router/app_router.dart';
import 'package:flutter_application_firebase/data_reposotries/fire_store_helper.dart';
import 'package:flutter_application_firebase/data_reposotries/storage_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    getAllCategories();
  }
  File? imageFile;
  TextEditingController catNameArController = TextEditingController();
  TextEditingController catNameEnController = TextEditingController();
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();

  addNewCategory() async {
    if (imageFile != null) {
      if (categoryFormKey.currentState!.validate()) {
        AppRouter.appRouter.showLoadingDialoug();
        String imageUrl = await StorageHelper.storageHelper
            .uploadNewImage("cats_images", imageFile!);
        Category category = Category(
            imageUrl: imageUrl,
            nameAr: catNameArController.text,
            nameEn: catNameEnController.text);

        String? id =
            await FireStoreHelper.fireStoreHelper.addNewCategory(category);
        AppRouter.appRouter.hideDialoug();
        if (id != null) {
          category.id = id;
          allCategories!.add(category);
          notifyListeners();
          catNameArController.clear();
          catNameEnController.clear();
          imageFile = null;
          notifyListeners();
          AppRouter.appRouter
              .showCustomDialooug('Success', 'Your category has been added');
        }
      }
    } else {
      AppRouter.appRouter
          .showCustomDialooug('Error', 'You have to pick image first');
    }
  }

  // addNewProduct() async {
  //   if (imageFile != null) {
  //     if (categoryFormKey.currentState!.validate()) {
  //       AppRouter.appRouter.showLoadingDialoug();
  //       String imageUrl = await StorageHelper.storageHelper
  //           .uploadNewImage("cats_images", imageFile!);
  //       Category category = Category(
  //           imageUrl: imageUrl,
  //           nameAr: catNameArController.text,
  //           nameEn: catNameEnController.text);

  //       String? id =
  //           await FireStoreHelper.fireStoreHelper.addNewCategory(category);
  //       AppRouter.appRouter.hideDialoug();
  //       if (id != null) {
  //         category.id = id;
  //         allCategories!.add(category);
  //         notifyListeners();
  //         catNameArController.clear();
  //         catNameEnController.clear();
  //         imageFile = null;
  //         notifyListeners();
  //         AppRouter.appRouter
  //             .showCustomDialooug('Success', 'Your category has been added');
  //       }
  //     }
  //   } else {
  //     AppRouter.appRouter
  //         .showCustomDialooug('Error', 'You have to pick image first');
  //   }
  // }

  pickImageForCategory() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  String? requiredValidation(String content) {
    if (content == null || content.isEmpty) {
      return 'Required field';
    }
    // v?.length ?? 0

    return null;
  }

  deleteCategory(Category category) async {
    AppRouter.appRouter.showLoadingDialoug();
    log('id in provider' + category.id!);
    bool deleteSuccess =
        await FireStoreHelper.fireStoreHelper.deleteCategory(category.id!);
    if (deleteSuccess) {
      allCategories!.remove(category);
      notifyListeners();
    }
    AppRouter.appRouter.hideDialoug();
  }

  List<Category>? allCategories;
  List<Product>? allProducts;
  getAllCategories() async {
    allCategories = await FireStoreHelper.fireStoreHelper.getAllCategoried();
    notifyListeners();
  }

  goToEditCategoryPage(Category category) {
    catNameArController.text = category.nameAr;
    catNameEnController.text = category.nameEn;
    AppRouter.appRouter.goToWidget(EditCategory(category));
  }

  updateCategory(Category category) async {
    if (imageFile != null) {
      AppRouter.appRouter.showLoadingDialoug();
      String imageUrl = await StorageHelper.storageHelper
          .uploadNewImage("cats_images", imageFile!);
      category.imageUrl = imageUrl;
    }
    Category newCategory = Category(
        id: category.id,
        imageUrl: category.imageUrl,
        nameAr: catNameArController.text.isEmpty
            ? category.nameAr
            : catNameArController.text,
        nameEn: catNameEnController.text.isEmpty
            ? category.nameEn
            : catNameEnController.text);
    bool? isUpdated =
        await FireStoreHelper.fireStoreHelper.updateCategory(newCategory);
    if (isUpdated != null && isUpdated) {
      int index = allCategories!.indexOf(category);
      allCategories![index] = newCategory;
      imageFile = null;
      catNameArController.clear();
      catNameEnController.clear();
      notifyListeners();
      AppRouter.appRouter.hideDialoug();
      AppRouter.appRouter.hideDialoug();
    }
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  GlobalKey<FormState> addProductKey = GlobalKey();

  addNewProduct(String catId) async {
    if (imageFile != null) {
      if (addProductKey.currentState!.validate()) {
        AppRouter.appRouter.showLoadingDialoug();
        String imageUrl = await StorageHelper.storageHelper
            .uploadNewImage("products_images", imageFile!);
        Product product = Product(
            imageUrl: imageUrl,
            name: productNameController.text,
            description: productDescriptionController.text,
            price: productPriceController.text,
            catId: catId);

        String? id =
            await FireStoreHelper.fireStoreHelper.addNewProduct(product);

        AppRouter.appRouter.hideDialoug();
        if (id != null) {
          product.id = id;
          allProducts?.add(product);
          notifyListeners();
          productNameController.clear();
          productDescriptionController.clear();
          productPriceController.clear();
          imageFile = null;
          notifyListeners();
          AppRouter.appRouter
              .showCustomDialooug('Success', 'Your Product has been added');
        }
      }
    } else {
      AppRouter.appRouter
          .showCustomDialooug('Error', 'You have to pick image first');
    }
  }

  getAllProducts(String catId) async {
    allProducts = null;
    notifyListeners();
    List<Product>? product =
        await FireStoreHelper.fireStoreHelper.getAllProduct(catId);
    allProducts = product;
    notifyListeners();
  }
}
