// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/product_screen.dart';
import 'package:new_app/service/service_request.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../service/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
  AuthMode _authMode = AuthMode.Login;

  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _usenameController = TextEditingController();
  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('An Error Occurred!'),
  //       content: Text(message),
  //       actions: <Widget>[
  //         TextButton(
  //           child: Text('Okay'),
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Future<void> _submit() async {
  //   if (!_formKey.currentState!.validate()) {
  //     // Invalid!
  //     return;
  //   }
  //   _formKey.currentState!.save();
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     if (_authMode == AuthMode.Login) {
  //       // // Log user in
  //       // await Provider.of<Auth>(context, listen: false)
  //       //     .logIn(_authData['email']!, _authData['password']!);
  //       print('login');
  //     } else {
  //       // Sign user up
  //       // await Provider.of<Auth>(context, listen: false)
  //       //     .singUp(_authData['email']!, _authData['password']!);
  //       // print('signup');
  //     }
  //   } on HttpException catch (error) {
  //     var errorMessage = 'Authentication failed';
  //     if (error.toString().contains('EMAIL_EXISTS')) {
  //       errorMessage = 'This email address is already in use.';
  //     } else if (error.toString().contains('INVALID_EMAIL')) {
  //       errorMessage = 'This is not a valid email address';
  //     } else if (error.toString().contains('WEAK_PASSWORD')) {
  //       errorMessage = 'This password is too weak.';
  //     } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
  //       errorMessage = 'Could not find a user with that email.';
  //     } else if (error.toString().contains('INVALID_PASSWORD')) {
  //       errorMessage = 'Invalid password.';
  //     }
  //     _showErrorDialog(errorMessage);
  //   } catch (error) {
  //     const errorMessage =
  //         'Could not authenticate you. Please try again later.';
  //     _showErrorDialog(errorMessage);
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // void _switchAuthMode() {
  //   if (_authMode == AuthMode.Login) {
  //     setState(() {
  //       _authMode = AuthMode.Signup;
  //     });
  //   } else {
  //     setState(() {
  //       _authMode = AuthMode.Login;
  //     });
  //   }
  // }
  @override
  void initState() {
    _usenameController.text = "mor_2314";
    _passwordController.text = "83r5^_";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
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
                // if (_authMode == AuthMode.Signup)
                //   TextFormField(
                //     enabled: _authMode == AuthMode.Signup,
                //     decoration: InputDecoration(labelText: 'Confirm Password'),
                //     obscureText: true,
                //     validator: _authMode == AuthMode.Signup
                //         ? (value) {
                //             if (value != _passwordController.text) {
                //               return 'Passwords do not match!';
                //             }
                //           }
                //         : null,
                //   ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      // onPressed: _submit,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var result = await ServiceRequest().logIn(
                              _usenameController.text,
                              _passwordController.text);
                          //ServiceRequest().featchPoducts()
                          if (result == null) {
                            Get.snackbar(
                                "Error", "username or password is incorrect");
                          } else {
                            Map<String, dynamic> decodedToken =
                                JwtDecoder.decode(result);
                            print(decodedToken["sub"]);
                            Get.to(() => ProductScreen());
                          }
                        }
                      }),
                // TextButton(
                //   child: Text(
                //       '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                //   onPressed: _switchAuthMode,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
