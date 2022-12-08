import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/controller.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/screens/cart_screen.dart';
import 'package:new_app/service/service_request.dart';
import 'package:new_app/widgets/single_product.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController editingController = TextEditingController();
  MainController mainController = Get.put(MainController(), permanent: true);

  List<ProductModel> productData = [];
  List<ProductModel> searchList = [];
  List<ProductModel> newList = [];
  RxBool flag = true.obs;
  List<ProductModel> items = [];
  var obxList = <ProductModel>[].obs;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      newList = productData;
    } else {
      newList = productData
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    obxList.value = newList;
  }

  void loadData() async {
    ServiceRequest().featchPoducts().then((value) {
      productData = value!;
      items = productData;
      obxList.value = productData;

      flag.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              suffixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => CartScreen());
              },
              child: Text("Cart Screen")),
          SizedBox(
            height: 30,
          ),
          Obx(
            () => Container(
              child: Expanded(
                  child: flag.value == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 2 / 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: obxList.length,
                          itemBuilder: ((context, index) =>
                              SingleProduct(obxList[index])))),
            ),
          ),
        ]),
      )),
    );
  }
}
