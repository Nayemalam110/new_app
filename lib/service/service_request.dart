import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/controller/controller.dart';
import 'package:new_app/model/cart_model.dart';
import 'package:new_app/model/product_model.dart';

class ServiceRequest {
  var apiUrl = 'https://fakestoreapi.com/';

  //load product
  MainController mainController = Get.put(MainController(), permanent: true);

  Future<List<ProductModel>?> featchPoducts() async {
    var url = Uri.parse("${apiUrl}products");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var productList = productModelFromJson(jsonString);

        return productList;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  //load cart for the user
  Future<List<CartModel>?> featchCart() async {
    var uid = mainController.UserId;
    var url = Uri.parse("${apiUrl}carts/user/$uid");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var cartList = cartModelFromJson(jsonString);
        print(cartList.length);

        return cartList;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //login

  Future<String?> logIn(userName, password) async {
    var url = Uri.parse("${apiUrl}auth/login");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "username": userName,
          "password": password,
        }),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var token = response.body;

        return token;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
