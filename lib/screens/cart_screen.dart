import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/controller.dart';
import 'package:new_app/model/cart_model.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/service/service_request.dart';
import 'package:new_app/widgets/single_cart.dart';
import 'package:new_app/widgets/single_product.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController editingController = TextEditingController();

  List<CartModel> cartData = [];
  bool cartFlag = true;
  List<Product>? products;

  @override
  void initState() {
    loadCart();
    super.initState();
  }

  void loadCart() async {
    ServiceRequest().featchCart().then((value) {
      cartData = value!;
      products = cartData[0].products;

      setState(() {
        cartFlag = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: cartFlag
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 5 / 2,
                              crossAxisCount: 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5),
                      itemCount: products!.length,
                      itemBuilder: ((context, index) =>
                          SingleCart(products![index])))),
        ]),
      )),
    );
  }
}
