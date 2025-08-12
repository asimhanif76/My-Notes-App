import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/sign_in_controller.dart';
import 'package:notes_app/Utils/app_size.dart';
import 'package:notes_app/Utils/email_password_validator.dart';
import 'package:notes_app/Views/SignIn-SignUp-Screens/sign_up_screen.dart';
import 'package:notes_app/Widgets/my_button.dart';
import 'package:notes_app/Widgets/my_text_form_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    double w = AppSize.width(context);
    double h = AppSize.height(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.03),
        child: Form(
          key: signInController.formkeySignIn,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: h * 0.02),
              Image.asset('assets/images/app_logo.png', height: 60),
              SizedBox(height: h * 0.01),
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
                  controller: signInController.emailController,
                  validator: EmailPasswordValidators.validateEmail,
                  hintText: 'Email',
                  icon: Icon(Icons.email)),
              MyTextFormField(
                  controller: signInController.passwordController,
                  validator: EmailPasswordValidators.validatePassword,
                  hintText: 'Password',
                  icon: Icon(Icons.lock),
                  isPasswordField: true),
              SizedBox(height: h * 0.03),
              MyButton(
                color: Colors.purple.shade300,
                widget: Obx(
                  () => signInController.isLoading.value
                      ? Transform.scale(
                          scale: 0.6,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                ),
                onTap: () {
                  signInController.signIn(context);
                },
              ),
              Spacer(),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
                child: Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    color: Colors.purple.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
