import 'package:e_commerce/provider/modelHud.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widget/buttonLogin.dart';
import 'package:e_commerce/widget/signup_all_Text/signup_text.dart';
import 'package:e_commerce/widget/signup_all_Text/vertical_text.dart';
import 'package:e_commerce/widget/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  static String id = 'SignupScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
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
                              VerticlSignup(),
                              TextSignup(),
                            ],
                          ),
                        ),
                        TextFields(
                          onClick: () {},
                          hint: 'Enter your Name',
                          label: 'Name',
                          icon: Icons.perm_identity,
                        ),
                        SizedBox(
                          height: height * 0.02,
                          width: MediaQuery.of(context).size.width,
                        ),
                        TextFields(
                          onClick: (value) {
                            _email = value;
                          },
                          hint: 'Enter your Email',
                          label: 'Email',
                          icon: Icons.email,
                        ),
                        SizedBox(
                          height: height * 0.02,
                          width: MediaQuery.of(context).size.width,
                        ),
                        TextFields(
                          onClick: (value) {
                            _password = value;
                          },
                          hint: 'Enter your Password',
                          label: 'Password',
                          icon: Icons.vpn_key,
                        ),
                        SizedBox(
                          height: height * 0.02,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Builder(
                          builder: (context) => Button(
                            text: 'Sign Up',
                            icon: Icons.arrow_forward,
                            onPressed: () async {
                              final modelHud =
                                  Provider.of<ModelHud>(context, listen: false);
                              modelHud.changeIsLoading(true);
                              if (_globalKey.currentState.validate()) {
                                _globalKey.currentState.save();
                                try {
                                  final authRegister =
                                      await _auth.signUp(_email, _password);
                                  modelHud.changeIsLoading(false);
                                } on PlatformException catch (e) {
                                  modelHud.changeIsLoading(false);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(e.message),
                                  ));
                                }
                                modelHud.changeIsLoading(false);
                              }
                            },
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
}
