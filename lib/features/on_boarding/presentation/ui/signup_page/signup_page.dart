import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/core/ui_helper/custom_widgets/elevated_btn.dart';
import 'package:ecommerce/core/ui_helper/ui_helper/textfield_decor.dart';
import 'package:ecommerce/features/on_boarding/presentation/bloc/user_bloc.dart';
import 'package:ecommerce/features/on_boarding/presentation/bloc/user_event.dart';
import 'package:ecommerce/features/on_boarding/presentation/bloc/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';

class SignupPage extends StatelessWidget {
  bool isPasswordVisible = false;
  bool isLoading = false;

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();
  var nameController = TextEditingController();
  var mobileNoController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.mainAppColor,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(12),
              width: 350,
              height: 600,
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
                      "Create An Account",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your Name";
                        }
                        if (value.length < 3) {
                          return "Please Enter valid Name";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      controller: nameController,
                      decoration: textFieldDecor(
                        hint: "Enter Your Name Here ...",
                        label: "Name",
                      ),
                    ),
                    SizedBox(height: 11),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your Name";
                        }
                        if (value.length < 10) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      controller: mobileNoController,
                      decoration: textFieldDecor(
                        hint: "Enter Your Mobile No here ...",
                        label: "Mobile No",
                      ),
                    ),
                    SizedBox(height: 11),
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
                            final bool passValid = RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                            ).hasMatch(value ?? "");
                            if (value == null || value.isEmpty) {
                              return "Please Enter  Password";
                            }
                            if (!passValid) {
                              return "Please Enter valid Password";
                            }
                            return null;
                          },
                          obscureText: isPasswordVisible,
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
                    StatefulBuilder(
                      builder: (context, ss) {
                        return TextFormField(
                          controller: confirmPassController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Re_type Your Password";
                            }
                            if (value != passController.text) {
                              return "Please Enter Same Password";
                            }
                            return null;
                          },
                          obscureText: isPasswordVisible,
                          style: TextStyle(color: Colors.white),
                          decoration: textFieldDecor(
                            hint: "Re_Enter Your password here ...",
                            label: "Confirm Password",
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
                    BlocListener<UserBloc, UserState>(
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
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Your Account has Created Successfully"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: ElevatedBtn(
                        btnName: "Sign Up",
                        isWidget: true,
                        widget: isLoading
                            ? CircularProgressIndicator()
                            : Container(),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<UserBloc>().add(UserRegisterEvent(
                                email: emailController.text,
                                password: passController.text,
                                name: nameController.text,
                                mobNo: mobileNoController.text));
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 11),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already Have an Account ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: "Log In",
                              style: TextStyle(
                                color: Colors.white,
                                backgroundColor: AppColors.mainAppColor,
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
