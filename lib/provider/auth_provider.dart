// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_firebase/app_router/app_router.dart';
import 'package:flutter_application_firebase/auth/auth_helper.dart';
import 'package:flutter_application_firebase/data_reposotries/fire_store_helper.dart';
import 'package:flutter_application_firebase/data_reposotries/storage_helper.dart';
import 'package:flutter_application_firebase/model/user_model.dart';
import 'package:flutter_application_firebase/screen/main_screen.dart';
import 'package:flutter_application_firebase/screen/sign_in_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> signInKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AppUser? loggedUser;
  //  String? email;
  // late String password;

  // saveEmail(String email) {
  //   this.email = email;
  // }

  // savePassword(String password) {
  //   this.password = password;
  // }

  String? emailValidation(String email) {
    if (email == null || email.isEmpty) {
      return 'Required field';
    } else if (!(isEmail(email))) {
      return 'Incorrect Email Syntax';
    }
    // v?.length ?? 0

    return null;
  }

  String? passwordValidation(String password) {
    if (password == null || password.isEmpty) {
      return 'Required field';
    } else if ((password.length <= 6)) {
      return 'Error , the password must be larger that 6 charchater';
    }
    // v?.length ?? 0

    return null;
  }

  String? requiredValidation(String content) {
    if (content == null || content.isEmpty) {
      return 'Required field';
    }
    // v?.length ?? 0

    return null;
  }

  String? phoneValidation(String content) {
    if (content.isEmpty) {
      return 'Incorrect number syntaxx';
    }
    // v?.length ?? 0

    return null;
  }

  signIn() async {
    if (signInKey.currentState!.validate()) {
      signInKey.currentState!.save();
      String? userID = await AuthHelper.authHelper
          .signIn(loginEmailController.text, passwordController.text);
      if (userID != null) {
        loggedUser =
            await FireStoreHelper.fireStoreHelper.getUserFromFirestore(userID);
        notifyListeners();
        AppRouter.appRouter.goToPageAndReplace(MainScreen());
      }
      // log(email);
      // log(password);
    }
  }

  SignUp() async {
    if (signUpKey.currentState!.validate()) {
      // signUpKey.currentState!.save();
      log(registerEmailController.text);
      log(passwordRegisterController.text);
      String? result = await AuthHelper.authHelper.signUp(
          registerEmailController.text, passwordRegisterController.text);
      if (result != null) {
        FireStoreHelper.fireStoreHelper.addNewUSer(AppUser(
            id: result,
            email: registerEmailController.text,
            userName: userNameController.text,
            phoneNumer: phoneController.text));
        log('suceesssssssssssssssssssss');
        // AppRouter.appRouter.goToPageAndReplace(MainScreen());
      }
      // log(email);
      // log(password);
    }
  }

  getUser(String id) async {
    loggedUser = await FireStoreHelper.fireStoreHelper.getUserFromFirestore(id);
    loggedUser!.id = id;
    notifyListeners();
  }

  checkUser() async {
    await Future.delayed(const Duration(seconds: 3));
    String? userID = AuthHelper.authHelper.checkUser();
    if (userID != null) {
      getUser(userID);
      AppRouter.appRouter.goToPageAndReplace(MainScreen());
    } else {
      AppRouter.appRouter.goToPageAndReplace(SignInScreen());
    }
  }

  signOut() async {
    await AuthHelper.authHelper.signOut();
    AppRouter.appRouter.goToPageAndReplace(SignInScreen());
  }

  uploadNewFile() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(pickedFile!.path);
    String imageUrl =
        await StorageHelper.storageHelper.uploadNewImage('user_images', file);
    loggedUser!.imageUrl = imageUrl;
    await FireStoreHelper.fireStoreHelper.updateTheUser(loggedUser!);
    getUser(loggedUser!.id!);
  }
}
