import 'package:get/get.dart';
import 'package:new_app/model/cart_model.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/service/service_request.dart';

class MainController extends GetxController {
  var UserId;
  List<ProductModel>? productData;

  List<CartModel> cart = [CartModel(id: 1)];
  var count = 0;
  @override
  void onInit() {
    loadProduct();
    // TODO: implement onInit
    super.onInit();
  }

  void loadProduct() async {
    productData = await ServiceRequest().featchPoducts();
    print(count++);
  }

  void addToCart(CartModel data) {
    var a = cart.firstWhereOrNull((element) => element.id == data.id);

    print(cart.length);
    // data.id =5;

    if (a == null) {
      cart.add(data);
      print("Null");
    } else {
      print('Not Null');
    }

    //     if (_item.containsKey(productId)) {
    //   _item.update(
    //     productId,
    //     (value) => CartItem(
    //         id: value.id,
    //         title: value.title,
    //         quantity: value.quantity + 1,
    //         price: value.price),
    //   );
    // } else {
    //   _item.putIfAbsent(
    //       productId,
    //       () => CartItem(
    //             id: DateTime.now().toString(),
    //             title: title,
    //             quantity: 1,
    //             price: price,
    //           ));
    // }
  }

  void removeFromCart() {}
}
