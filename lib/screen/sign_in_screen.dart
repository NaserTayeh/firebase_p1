// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_firebase/app_router/app_router.dart';
import 'package:flutter_application_firebase/component/custom_textfield.dart';
import 'package:flutter_application_firebase/provider/auth_provider.dart';
import 'package:flutter_application_firebase/screen/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Consumer<AuthProvider>(
        builder: ((context, provider, child) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: provider.signInKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      validation: provider.emailValidation,
                      label: 'Email',
                      controller: provider.loginEmailController,
                      isPassword: false,
                      textInputType: TextInputType.emailAddress,
                      // saveFunction: provider.saveEmail,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      validation: provider.passwordValidation,
                      label: 'Password',
                      controller: provider.passwordController,
                      isPassword: true,
                      textInputType: TextInputType.text,
                      // saveFunction: provider.savePassword,
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          await provider.signIn();
                        },
                        child: Text('Sign In')),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          AppRouter.appRouter
                              .goToPageAndReplace(SignUpScreen());
                        },
                        child: Text('Go To SignUp page'))
                  ],
                )),
          );
        }),
      ),
    );
  }
}
