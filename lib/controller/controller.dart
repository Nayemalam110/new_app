import 'package:get/get.dart';
import 'package:new_app/model/cart_model.dart';
import 'package:new_app/model/new_cart_model.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/service/service_request.dart';

class MainController extends GetxController {
  var UserId;
  List<ProductModel>? productData;
  Map<String, CartItem> item = {};

  double get totalAmount {
    var total = 0.00;
    item.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  var count = 0;
  @override
  void loadProduct() async {
    productData = await ServiceRequest().featchPoducts();
    print(count++);
  }

  void removeSingleItem(productId) {
    if (!item.containsKey(productId)) {
      return;
    } else if (item[productId]!.quantity > 1) {
      item.update(
          productId,
          (value) => CartItem(
                id: value.id,
                title: value.title,
                quantity: value.quantity - 1,
                price: value.price,
              ));
    } else {
      item.remove(productId);
    }
  }

  void addItem(
    String productId,
    num price,
    String title,
  ) {
    if (item.containsKey(productId)) {
      item.update(
        productId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            quantity: value.quantity + 1,
            price: value.price),
      );
    } else {
      item.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
  }
}
