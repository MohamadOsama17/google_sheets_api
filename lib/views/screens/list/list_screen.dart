import 'package:flutter/material.dart';
import 'package:google_sheet_task/locator.dart';
import 'package:google_sheet_task/logic/vm/productList_vm.dart';
import 'package:google_sheet_task/views/shared/utils/colors.dart';
import 'package:google_sheet_task/views/shared/widgets/productCard.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    sl<ProductListViewModel>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sl<ProductListViewModel>(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 20,
                ),
                child: Text(
                  'All Products',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer<ProductListViewModel>(
                builder: (context, model, child) {
                  return Expanded(
                    child: model.isLoading
                        ? Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.secondaryColor,
                                ),
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              await model.loadProducts();
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              itemBuilder: (context, index) {
                                return model.products.isEmpty
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                (0.5),
                                        alignment: Alignment.center,
                                        child: Text('Product list empty !'),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                        ),
                                        child: ProductCard(
                                          product: model.products[index],
                                        ),
                                      );
                              },
                              itemCount: model.products.isEmpty
                                  ? 1
                                  : model.products?.length,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
