// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/controller.dart';
import 'package:new_app/screens/product_screen.dart';
import 'package:new_app/service/service_request.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white12,
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),

                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _usenameController = TextEditingController();
  MainController mainController = Get.put(MainController(), permanent: true);
  @override
  void initState() {
    _usenameController.text = "mor_2314";
    _passwordController.text = "83r5^_";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _usenameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter UserName';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is too short!';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                          child: Text('LOGIN'),
                          // onPressed: _submit,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var result = await ServiceRequest().logIn(
                                  _usenameController.text,
                                  _passwordController.text);
                              //ServiceRequest().featchPoducts()
                              if (result == null) {
                                Get.snackbar("Error",
                                    "username or password is incorrect");
                              } else {
                                Map<String, dynamic> decodedToken =
                                    JwtDecoder.decode(result);

                                print(decodedToken["sub"]);
                                mainController.UserId = decodedToken["sub"];
                                mainController.loadProduct();
                                Get.to(() => ProductScreen());
                              }
                            }
                          }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
