import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/signup_screen.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String id = 'loginPage';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

GlobalKey<FormState> globalKey = GlobalKey();
String? email, password;
bool isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
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
                Image.asset('assets/images/scholar.png'),
                Text(
                  'Scolar Chat',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 32,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                CustomTextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
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
                              await SigninUser();
                              Navigator.pushNamed(context, ChatScreen.id,
                                  arguments: email);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showSnackBar(
                                    context, 'No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                showSnackBar(context,
                                    'Wrong password provided for that user.');
                              }
                            } catch (e) {
                              print(e);
                            }
                            isLoading = false;
                            setState(() {});
                          }
                        },
                        child: Text('Login'))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account ?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignupScreen.id);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return SignupScreen();
                          // }));
                        },
                        child: Text('SignUp')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> SigninUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
