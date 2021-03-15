import 'package:e_commerce/constans.dart';
import 'package:e_commerce/provider/adminMode.dart';
import 'package:e_commerce/provider/modelHud.dart';
import 'package:e_commerce/screens/register.dart';
import 'package:e_commerce/screens/user/homePage.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widget/buttonLogin.dart';
import 'package:e_commerce/widget/login_text.dart';
import 'package:e_commerce/widget/text_fields.dart';
import 'package:e_commerce/widget/vertical_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adminHome.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _email, _password;

  final _auth = Auth();

  final adminpassword = '1234567';

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: Row(
                            children: [
                              VerticlText(),
                              TextLogin(),
                            ],
                          ),
                        ),
                        TextFields(
                          onClick: (value) {
                            _email = value;
                          },
                          hint: 'Enter your Email',
                          label: 'Email',
                          icon: Icons.email,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                                child: Checkbox(
                                  checkColor: Colors.red,
                                  value: keepMeLoggedIn,
                                  onChanged: (value) {
                                    setState(() {
                                      keepMeLoggedIn = value;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                'Remmber Me',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        TextFields(
                          onClick: (value) {
                            _password = value;
                          },
                          hint: 'Enter your Password',
                          label: 'Passwoed',
                          icon: Icons.email,
                        ),
                        SizedBox(
                          height: height * 0.04,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Builder(
                          builder: (context) => Button(
                              text: 'Login',
                              icon: Icons.arrow_forward,
                              onPressed: () async {
                                if (keepMeLoggedIn == true) {
                                  keepUserLoggedIn();
                                }
                                _validate(context);
                              }),
                        ),
                        SizedBox(
                          height: height * 0.02,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t Have An Account ?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, SignupScreen.id);
                              },
                              child: Text(
                                'Register',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Provider.of<AdminMode>(context, listen: false)
                                      .changeIsAdmin(true);
                                },
                                child: Text(
                                  'i\'m Admin',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Provider.of<AdminMode>(context)
                                              .isAdmin
                                          ? Colors.blueGrey
                                          : Colors.white),
                                ),
                              )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Provider.of<AdminMode>(context, listen: false)
                                      .changeIsAdmin(true);
                                },
                                child: Text(
                                  'i\'m User',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Provider.of<AdminMode>(context)
                                              .isAdmin
                                          ? Colors.white
                                          : Colors.blueGrey),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password.trim() == adminpassword) {
          try {
            await _auth.signIn(_email.trim(), _password.trim());
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelHud.changeIsLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.massage),
            ));
          }
        } else {
          modelHud.changeIsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('someThing went worng !'),
          ));
        }
      } else {
        try {
          await _auth.signIn(_email.trim(), _password.trim());
          Navigator.pushReplacementNamed(context, HomePage.id);
        } catch (e) {
          modelHud.changeIsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.massage),
          ));
        }
      }

      modelHud.changeIsLoading(false);
    }
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
