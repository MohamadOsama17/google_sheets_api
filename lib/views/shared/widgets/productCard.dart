
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sheet_task/logic/models/product.dart';
import 'package:google_sheet_task/logic/vm/productList_vm.dart';
import 'package:google_sheet_task/views/shared/utils/colors.dart';

import '../../../locator.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Name : ${product.name}',
              style: TextStyle(
                height: 1.4,
                color: AppColors.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Model Number : ${product.modelNumber}',
              style: TextStyle(
                height: 1.4,
                color: AppColors.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Purches Date : ${product.purchesDate?.toString()?.split(' ')?.first ?? '-'}',
              style: TextStyle(
                height: 1.4,
                color: AppColors.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'email : ${product.email ?? '-'}',
              style: TextStyle(
                height: 1.4,
                color: AppColors.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  // print(product.id);
                  sl<ProductListViewModel>().deleteProduct(
                    productId: product.id,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
