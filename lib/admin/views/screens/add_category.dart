// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_firebase/admin/provider/admin_provider.dart';
import 'package:flutter_application_firebase/component/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Category'),
      ),
      body: Consumer<AdminProvider>(
        builder: (context, provider, x) {
          return Form(
            key: provider.categoryFormKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      provider.pickImageForCategory();
                    },
                    child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey,
                        child: provider.imageFile == null
                            ? Center(
                                child: Icon(Icons.camera),
                              )
                            : Image.file(
                                provider.imageFile!,
                                fit: BoxFit.cover,
                              )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      validation: provider.requiredValidation,
                      label: 'Category Arabic name',
                      controller: provider.catNameArController,
                      textInputType: TextInputType.text),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      validation: provider.requiredValidation,
                      label: 'Category English name',
                      controller: provider.catNameEnController,
                      textInputType: TextInputType.text),
                  Spacer(),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            provider.addNewCategory();
                          },
                          child: Text('Add new Category')))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
