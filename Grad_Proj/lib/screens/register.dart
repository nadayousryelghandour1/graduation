// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/cubit/user_cubit.dart';
import 'package:grd_proj/cubit/user_state.dart';
import 'package:grd_proj/screens/verify_page.dart';

class Rigester extends StatefulWidget {
  const Rigester({super.key});
  @override
  State<Rigester> createState() => _RigesterState();
}

String phonepattern = r'^[+]{1}(?:[0-9\-\(\)\/\.]\s?){6, 15}[0-9]{1}$';
RegExp phoneNumber = RegExp(phonepattern);

class _RigesterState extends State<Rigester> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool obscureText2 = true;
  bool isChecked = false;
  List? email;
  List? password;
  List? firstName;
  List? lastName;
  List? userName;
  List? phoneNumber;
  Map? errors;
  void equal(Map errors) {
    email = errors['email'] ?? [];
    password = errors['Password'] ?? [];
    firstName = errors['firstName'] ?? [];
    lastName = errors['lastName'] ?? [];
    userName = errors['UserName'] ?? [];
    phoneNumber = errors['phoneNumber'] ?? [];
    print("=============$password=============");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is SignUpSuccess) {
        ScaffoldMessenger.of(context).clearSnackBars();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("success"),
            ),
          );
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => VerifyPage()));
      } else if (state is SignUpFailure) {
        
        errors = state.errors;
        equal(state.errors);
        context.read<UserCubit>().signUpFormKey.currentState!.validate();
        ScaffoldMessenger.of(context).clearSnackBars();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        });
      }
    }, builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Column(
                  children: [
                    // Welcome Text
                    const SizedBox(height: 60),
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Manrope",
                        color: Color(0xff1E6930),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Create your own account',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Manrope",
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Email and Password Fields
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: context.read<UserCubit>().signUpFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller:
                                  context.read<UserCubit>().signUpFirstName,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "First Name",
                                hintStyle: TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      BorderSide(color: errorColor, width: 3.0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                // if (userName != null) {
                                //   print("$userName");
                                //   return errors!['UserName'][0];
                                // }
                                // return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller:
                                  context.read<UserCubit>().signUpLastName,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "Last Name",
                                hintStyle: TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      BorderSide(color: errorColor, width: 3.0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                // if (value!.isEmpty) {
                                //   return errors!['UserName'][0];
                                // }
                                // return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: context.read<UserCubit>().signUpName,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "User Name",
                                hintStyle: TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      BorderSide(color: errorColor, width: 3.0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your User Name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: context.read<UserCubit>().signUpEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Enter your Email",
                                hintStyle: TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      BorderSide(color: errorColor, width: 3.0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your email";
                                } else if (!value.contains("@")) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: passwordController,
                              obscureText: obscureText,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                hintText: "Enter your  Password",
                                hintStyle: TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      BorderSide(color: errorColor, width: 3.0),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    icon: Icon(obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                // if (password != []) {
                                //   return password![1];
                                // }
                                // return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              obscureText: obscureText2,
                              controller: confirmPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                hintText: "Enter your  Password",
                                hintStyle: TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      BorderSide(color: errorColor, width: 3.0),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText2 = !obscureText2;
                                      });
                                    },
                                    icon: Icon(obscureText2
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value != passwordController.text) {
                                  return 'Please confirm your password';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller:
                                  context.read<UserCubit>().signUpPhoneNumber,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                hintStyle: TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      BorderSide(color: errorColor, width: 3.0),
                                ),
                              ),
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your number';
                                }
                                // else if (!phoneNumber.hasMatch(value)) {
                                //   return 'Please enter a valid phone number';
                                // }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Remember Me and Forgot Password Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                activeColor: const Color(0xff1E6930),
                                tristate: false,
                                onChanged: (newbool) {
                                  setState(() {
                                    isChecked = newbool!;
                                  });
                                },
                              ),
                              const Text('I agree to ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: "Manrope")),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Rigester()));
                            },
                            child: const Text(
                              ' Terms and Conditions and Privacy Statement',
                              style: TextStyle(
                                color: Color(0xff1E6930),
                                fontSize: 13,
                                fontFamily: "Manrope",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 23),

                    // Login Button
                    state is SignUpLoading
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SizedBox(
                              width: 227,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff1E6930),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8)),
                                onPressed: () {
                                  if (isChecked) {
                                    context
                                        .read<UserCubit>()
                                        .signUpFormKey
                                        .currentState!
                                        .validate();
                                    if (confirmPasswordController.text ==
                                        passwordController.text) {
                                      context.read<UserCubit>().signUpPassword =
                                          passwordController;

                                      BlocProvider.of<UserCubit>(context)
                                          .singUp();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please Confirm Your Password')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Please accept out Terms and Conditions and Privacy Statement"),
                                        ),
                                      );
                                    });
                                  }
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),

                    // Footer Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? ',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 18,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xff1E6930),
                              fontSize: 18,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
