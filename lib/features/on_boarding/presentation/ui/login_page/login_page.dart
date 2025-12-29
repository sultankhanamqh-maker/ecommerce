import 'package:ecommerce/core/app_routes/app_routes.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/core/ui_helper/custom_widgets/elevated_btn.dart';
import 'package:ecommerce/core/ui_helper/ui_helper/textfield_decor.dart';
import 'package:ecommerce/features/on_boarding/presentation/bloc/user_event.dart';
import 'package:ecommerce/features/on_boarding/presentation/bloc/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;

  var emailController = TextEditingController();

  var passController = TextEditingController();

  bool isLoading = false;

  bool isLogIn = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppConstants.appColor,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(12),
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 11),
                    Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value ?? "");
                        if (value == null || value.isEmpty) {
                          return "Please Enter your email";
                        }
                        if (!emailValid) {
                          return "Please Enter valid Email";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: textFieldDecor(
                        hint: "Enter Your Email here ...",
                        label: "Email",
                      ),
                    ),
                    SizedBox(height: 11),

                    StatefulBuilder(
                      builder: (context, ss) {
                        return TextFormField(
                          controller: passController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter your Password";
                            }
                            return null;
                          },
                          obscureText: !isPasswordVisible,
                          style: TextStyle(color: Colors.white),
                          decoration: textFieldDecor(
                            hint: "Enter Your password here ...",
                            label: "Password",
                            isIcon: true,
                            isVisible: isPasswordVisible,
                            onTap: () {
                              isPasswordVisible = !isPasswordVisible;
                              ss(() {});
                            },
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 11),
                    BlocListener<UserBloc,UserState>(
                      listenWhen: (pre,next){
                        return isLogIn;
                      },
                      listener: (context, state) {
                        if (state is UserLoadingState) {
                          isLoading = true;
                        }
                        if (state is UserErrorState) {
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMsg),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if (state is UserLoadedState) {
                          isLoading = false;
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.homePage,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Your are Logged in Successfully"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: ElevatedBtn(
                        btnName: "Log In",
                        isWidget: true,
                        widget: isLoading ? CircularProgressIndicator() : Container(),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            isLogIn = true;
                            context.read<UserBloc>().add(
                              UserLoginEvent(
                                password: passController.text,
                                email: emailController.text,
                              ),
                            );
                          }
                        },

                      ),
                    ),
                    SizedBox(height: 11),
                    InkWell(
                      onTap: () {
                        isLogIn = false;
                        Navigator.pushNamed(context, AppRoutes.signUpPage);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Create an Account ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                backgroundColor: AppConstants.appColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
