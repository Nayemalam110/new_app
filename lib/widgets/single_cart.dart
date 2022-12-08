import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/controller.dart';
import 'package:new_app/model/cart_model.dart';
import 'package:new_app/model/product_model.dart';

class SingleCart extends StatelessWidget {
  SingleCart(this.products);
  Product? products;
  String? title;
  String? imageUrl;
  String? price;
  String? total;

  MainController mainController = Get.put(MainController(), permanent: true);

  ProductModel? productData;
  void loadData() {
    productData = mainController.productData!
        .firstWhere((element) => element.id == products!.productId);
    imageUrl = productData!.image;
    title = productData!.title;
    price = productData!.price.toString();
    var t = products!.quantity! * productData!.price!;
    total = t.toString();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Card(
      elevation: .5,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  height: 100,
                  width: 80,
                  child: Image.network(imageUrl!),
                )),
            SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        price.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                      Text(
                        total.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      )
                    ]),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints(maxHeight: 100),
                decoration: BoxDecoration(
                    color: Color(0xffFFCCE4),
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.remove),
                      Text(products!.quantity.toString()),
                      Icon(Icons.add)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
