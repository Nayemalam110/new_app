import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/controller.dart';
import 'package:new_app/model/cart_model.dart';
import 'package:new_app/model/product_model.dart';

class SingleCart extends StatefulWidget {
  SingleCart(this.products);
  Product? products;

  @override
  State<SingleCart> createState() => _SingleCartState();
}

class _SingleCartState extends State<SingleCart> {
  String? title;

  String? imageUrl;

  num price = 0;

  double total = 0;

  int quantity = 0;

  MainController mainController = Get.put(MainController(), permanent: true);

  ProductModel? productData;
  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }

  void loadData() {
    quantity = widget.products!.quantity!;
    productData = mainController.productData!
        .firstWhere((element) => element.id == widget.products!.productId);
    imageUrl = productData!.image;
    title = productData!.title;
    price = productData!.price as num;
    total = widget.products!.quantity! * productData!.price!;
  }

  void addProduct() {
    quantity = quantity + 1;
    total = quantity * productData!.price!;

    setState(() {});
  }

  void deleteProduct() {
    quantity = quantity - 1;
    total = quantity * productData!.price!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                      Text(
                        total.toString(),
                        style: const TextStyle(
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
                      if (quantity < 2) const SizedBox(),
                      if (quantity > 1)
                        InkWell(
                            onTap: () => deleteProduct(),
                            child: Icon(Icons.remove)),
                      Text(quantity.toString()),
                      InkWell(onTap: () => addProduct(), child: Icon(Icons.add))
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
