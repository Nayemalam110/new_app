import 'package:flutter/material.dart';
import 'package:new_app/model/product_model.dart';

class SingleProduct extends StatelessWidget {
  SingleProduct(this.productData);
  ProductModel productData;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(10),
                child: Image.network(
                  productData.image!,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.clip,
                productData.title!,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productData.price.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red),
                    )
                  ]),
            )
          ],
        ));
  }
}
