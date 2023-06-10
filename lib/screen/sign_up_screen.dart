// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_firebase/app_router/app_router.dart';
import 'package:flutter_application_firebase/component/custom_textfield.dart';
import 'package:flutter_application_firebase/data_reposotries/fire_store_helper.dart';
import 'package:flutter_application_firebase/provider/auth_provider.dart';
import 'package:flutter_application_firebase/screen/sign_in_screen.dart';
import 'package:provider/provider.dart';

import '../auth/auth_helper.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        return Form(
            key: provider.signUpKey,
            child: Column(
              children: [
                CustomTextField(
                  validation: provider.requiredValidation,
                  label: 'Name',
                  controller: provider.userNameController,
                  // isPassword: false ,
                  textInputType: TextInputType.text,
                  // saveFunction: provider.saveEmail,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: provider.phoneController,
                  validation: provider.phoneValidation,
                  label: 'Phone Number',
                  // isPassword: false ,
                  textInputType: TextInputType.phone,
                  // saveFunction: provider.saveEmail,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: provider.registerEmailController,

                  validation: provider.emailValidation,
                  label: 'Email',
                  // isPassword: false ,
                  textInputType: TextInputType.emailAddress,
                  // saveFunction: provider.saveEmail,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  validation: provider.passwordValidation,
                  label: 'Password',
                  controller: provider.passwordRegisterController,
                  isPassword: true,
                  textInputType: TextInputType.text,

                  // saveFunction: provider.savePassword,
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () async {
                      await provider.SignUp();
                    },
                    child: Text('Sign Up')),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      AppRouter.appRouter.goToPageAndReplace(SignInScreen());
                    },
                    child: Text('Go To Login Page')),
              ],
            ));
      }),
    );
  }
}
