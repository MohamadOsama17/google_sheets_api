import 'package:flutter/material.dart';
import 'package:google_sheet_task/locator.dart';
import 'package:google_sheet_task/logic/vm/productForm_vm.dart';
import 'package:google_sheet_task/views/shared/utils/colors.dart';
import 'package:google_sheet_task/views/shared/widgets/appInput.dart';
import 'package:provider/provider.dart';

class ProductFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sl<ProductFormViewModel>(),
      child: Scaffold(
        key: sl<ProductFormViewModel>().formSacffoldKey,
        body: SafeArea(
          child: Consumer<ProductFormViewModel>(
            builder: (context, model, child) {
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      vertical: 40,
                    ),
                    child: Text(
                      'Add Product',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AppInput(
                    title: 'Name',
                    // errorMessage: model.nameErrorMessage,
                    // hasError: model.nameErrorMessage != null,
                    controller: model.nameController,
                  ),
                  AppInput(
                    title: 'Mobile',
                    // hasError: model.mobileErrorMessage != null,
                    // errorMessage: model.mobileErrorMessage,
                    keyboardType: TextInputType.phone,
                    controller: model.mobileController,
                  ),
                  AppInput(
                    title: 'Model Number',
                    keyboardType: TextInputType.number,
                    controller: model.modelController,
                  ),
                  AppInput(
                    title: 'Purchase Date',
                    isDate: true,
                    pickedDate: model.pickedDate?.toString()?.split(' ')?.first,
                    pickDate: () async {
                      DateTime pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1, 1, 2020),
                        lastDate: DateTime(2025),
                      );
                      print(pickedDate);
                      sl<ProductFormViewModel>().pickDate(pickedDate);
                    },
                  ),
                  AppInput(
                    title: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: model.emailController,
                  ),
                  MaterialButton(
                    color: AppColors.primaryColor,
                    splashColor: AppColors.secondaryColor.withOpacity(0.5),
                    height: 48,
                    child: model.isLoading
                        ? Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.secondaryColor,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Add Product',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                    onPressed: () {
                      sl<ProductFormViewModel>().addProduct();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
