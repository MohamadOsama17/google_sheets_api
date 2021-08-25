import 'package:flutter/material.dart';
import 'package:google_sheet_task/locator.dart';
import 'package:google_sheet_task/logic/models/product.dart';
import 'package:google_sheet_task/logic/services/google_sheet_services.dart';

class ProductFormViewModel with ChangeNotifier {
  TextEditingController nameController = TextEditingController(),
      mobileController = TextEditingController(),
      modelController = TextEditingController(),
      emailController = TextEditingController();

  DateTime pickedDate;

  Product addedProduct;

  final _googleSheetsServices = sl<GoogleSheetsServices>();

  void pickDate(DateTime date) {
    if (date != null) {
      this.pickedDate = date;
      notifyListeners();
    }
  }

  ViewState _state = ViewState.loaded;

  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  bool get isLoading => _state == ViewState.loading;

  String nameErrorMessage;
  String mobileErrorMessage;

  final formSacffoldKey = GlobalKey<ScaffoldState>();

  Future addProduct() async {
    if (nameController.text.isNotEmpty && mobileController.text.isNotEmpty) {
      addedProduct = Product(
        name: nameController.text,
        email: emailController.text,
        ownerMobileNumber: mobileController.text,
        modelNumber: int.tryParse(modelController.text),
        purchesDate: pickedDate,
      );
      print(addedProduct.toGsheets());
      setState(ViewState.loading);
      bool isSuccess = await _googleSheetsServices.addProduct(addedProduct);
      setState(ViewState.loaded);
      if (isSuccess) {
        formSacffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Product added successfully'),
            backgroundColor: Colors.green,
          ),
        );
        nameErrorMessage = null;
        mobileErrorMessage = null;
        mobileController.clear();
        nameController.clear();
        modelController.clear();
        emailController.clear();
        pickedDate = null;
        notifyListeners();
      }
    } else {
      if (nameController.text.isEmpty) {
        nameErrorMessage = 'Product Name Is Required';
        formSacffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Product Name Is Required'),
            backgroundColor: Colors.red,
          ),
        );
        notifyListeners();
      } else if (mobileController.text.isEmpty) {
        mobileErrorMessage = 'Mobile Number Is Required';
        formSacffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Mobile Number Is Required'),
            backgroundColor: Colors.red,
          ),
        );
        notifyListeners();
      }
    }
  }
}

enum ViewState { loading, loaded }
