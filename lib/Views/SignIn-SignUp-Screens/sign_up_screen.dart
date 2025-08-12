import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Utils/app_size.dart';
import 'package:notes_app/Utils/email_password_validator.dart';
import 'package:notes_app/Widgets/my_button.dart';
import 'package:notes_app/Widgets/my_text_form_field.dart';
import 'package:notes_app/Controllers/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    double w = AppSize.width(context);
    double h = AppSize.height(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04, vertical: h * 0.03),
                  child: Form(
                    key: signUpController.formkeySignUp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: h * 0.05),
                        Image.asset('assets/images/app_logo.png', height: 60),
                        SizedBox(height: h * 0.02),
                        Text(
                          "My Notes",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade300,
                          ),
                        ),
                        Spacer(),
                        MyTextFormField(
                            controller: signUpController.nameController,
                            validator: (value) =>
                                value!.isEmpty ? 'Name cannot be empty' : null,
                            hintText: 'Name',
                            icon: Icon(Icons.email)),
                        MyTextFormField(
                            controller: signUpController.userNameController,
                            validator: EmailPasswordValidators.validateUsername,
                            hintText: 'User Name',
                            icon: Icon(Icons.email)),
                        MyTextFormField(
                            controller: signUpController.emailController,
                            validator: EmailPasswordValidators.validateEmail,
                            hintText: 'Email',
                            icon: Icon(Icons.email)),
                        MyTextFormField(
                            controller: signUpController.passwordController,
                            validator: EmailPasswordValidators.validatePassword,
                            hintText: 'Password',
                            icon: Icon(Icons.lock),
                            isPasswordField: true),
                        MyTextFormField(
                            controller:
                                signUpController.confirmPasswordController,
                            validator: EmailPasswordValidators.validatePassword,
                            hintText: 'Confirm Password',
                            icon: Icon(Icons.lock),
                            isPasswordField: true),
                        MyButton(
                          color: Colors.purple.shade300,
                          widget: Obx(
                            () => signUpController.isLoading.value
                                ? Transform.scale(
                                    scale: 0.6,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                          onTap: () {
                            signUpController.signUp(context);
                          },
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "You have an account? Sign In",
                            style: TextStyle(
                              color: Colors.purple.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
