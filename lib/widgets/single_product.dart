import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/controller.dart';
import 'package:new_app/model/cart_model.dart';
import 'package:new_app/model/new_cart_model.dart';
import 'package:new_app/model/product_model.dart';

class SingleProduct extends StatelessWidget {
  SingleProduct(this.productData);
  ProductModel productData;
  var quantity = 0;

  MainController mainController = Get.put(MainController());

  void addProduct() {
    quantity = quantity + 1;
    //  total = quantity * productData!.price!;

    // setState(() {});
  }

  void deleteProduct() {
    quantity = quantity - 1;
    //  total = quantity * productData!.price!;
    // setState(() {});
  }

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
              maxLines: 1,
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
          ),
          // Container(
          //   height: 30,
          //   constraints: BoxConstraints(maxWidth: 130),
          //   decoration: BoxDecoration(
          //       color: const Color(0xffFFCCE4),
          //       borderRadius: BorderRadius.circular(50)),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         if (quantity < 2) const SizedBox(),
          //         if (quantity > 1)
          //           InkWell(
          //               onTap: () =>
          //                   mainController.removeSingleItem(productData.id),
          //               child: Icon(Icons.remove)),
          //         Text(quantity.toString()),
          //         InkWell(
          //             onTap: () => mainController.addItem(
          //                 productData.id.toString(),
          //                 productData.price as num,
          //                 productData.title!),
          //             child: Icon(Icons.add))
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
