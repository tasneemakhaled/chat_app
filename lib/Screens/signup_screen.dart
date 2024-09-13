import 'dart:developer';

import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});
  static String id = 'SignUPScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          // backgroundColor: kPrimaryColor,
          body: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: globalKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'SignUp',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        onChanged: (data) {
                          email = data;
                        },
                        hintText: 'Email',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        obscureText: true,
                        onChanged: (data) {
                          password = data;
                        },
                        hintText: 'Password',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (globalKey.currentState!.validate()) {
                                isLoading = true;
                                setState(() {});
                                try {
                                  await RegisterUser();
                                  Navigator.pushNamed(context, ChatScreen.id,
                                      arguments: email);
                                  // showSnackBar(context, 'Sucess');
                                  // print(credential.user!.email);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    showSnackBar(context,
                                        'The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    showSnackBar(context,
                                        'The account already exists for that email.');
                                  }
                                } catch (e) {
                                  showSnackBar(context,
                                      'There was an error Please Try again');
                                }
                                isLoading = false;
                                setState(() {});
                              }
                            },
                            child: Text('Register'),
                          )),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account ?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Navigator.pushNamed(context, 'LoginScreen');
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return LoginScreen();
                                  // }));
                                },
                                child: Text('Login')),
                          ]),
                    ]),
              ))),
    );
  }

  Future<void> RegisterUser() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
