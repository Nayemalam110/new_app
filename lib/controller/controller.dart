import 'package:get/get.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/service/service_request.dart';

class MainController extends GetxController {
  var UserId;
  List<ProductModel>? productData;
  @override
  void onInit() {
    loadProduct();
    // TODO: implement onInit
    super.onInit();
  }

  void loadProduct() async {
    productData = await ServiceRequest().featchPoducts();
  }
}
