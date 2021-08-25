import 'package:flutter/material.dart';
import 'package:google_sheet_task/locator.dart';
import 'package:google_sheet_task/logic/models/product.dart';
import 'package:google_sheet_task/logic/services/google_sheet_services.dart';
import 'package:google_sheet_task/logic/vm/productForm_vm.dart';

class ProductListViewModel with ChangeNotifier {
  ViewState _state = ViewState.loaded;

  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  bool get isLoading => _state == ViewState.loading;

  List<Product> products = [];

  final _googleSheetsServices = sl<GoogleSheetsServices>();

  Future loadProducts() async {
    setState(ViewState.loading);
    products = await _googleSheetsServices.getAllProducts();
    setState(ViewState.loaded);
  }

  Future deleteProduct({int productId}) async {
    bool isDeleted = await _googleSheetsServices.deleteProduct(productId);
    if (isDeleted) {
      products.removeWhere(
        (element) => element.id == productId,
      );
      notifyListeners();
    }
  }
}
