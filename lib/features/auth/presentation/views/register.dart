import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/utils/validator.dart';
import 'package:supermarket/core/widgets/custom_awesome_dialog.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_event.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_auth_text_section.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_auth.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool isEmailValid = false;
   void validateEmail(String value) {
    final email = value;
    if (Validators.validateEmail(email) == null) {
      setState(() {
        isEmailValid = true;
      });
    } else {
      setState(() {
        isEmailValid = false;
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(Assets.imagesSingin),
          _buildContainer(screenSize, context),
        ],
      ),
    );
  }

  Widget _buildContainer(Size screenSize, context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 223),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomAuthTextSection(
              title: 'Sign Up',
              subtitle: 'Enter your credentials to continue',
            ),
          ),
          const SizedBox(height: 46),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  validator: (value) {
                    return Validators.validateUsername(value);
                  },
                  controller: usernameController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Username',
                    hintText: 'username',
                  ),
                ),
                CustomTextField(
                  onChanged: validateEmail,
                  validator: (value) {
                    return Validators.validateEmail(value);
                  },
                  controller: emailController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Email',
                    hintText: 'email',
                    suffixIcon: isEmailValid ? Image.asset(Assets.imagesVector) : null,
                  ),
                ),
                CustomTextField(
                  isPassword: isPassword,
                  validator: (value) {
                    return Validators.validatePassword(value);
                  },
                  controller: passwordController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Password',
                    hintText: '****',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: isPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('An account has been created successfully'),
                  backgroundColor: Colors.green,
                ));
                 Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
              } else if (state is AuthFailure) {
                CustomAwesomDialog.showErrorDialog(context, state.error);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator(color: primaryColor,);
              }
              return GestureDetector(
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final userName = usernameController.text;
                    final email = emailController.text;
                    final password = passwordController.text;

                    context
                        .read<AuthBloc>()
                        .add(RegisterEvent(userName: userName, email: email, password: password));
                  }
                },
                child: CustomButton(
                  text: 'Sign Up',
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),

          CustomTextAuth(text: 'Already have an account?', textAuth: 'Login', route: AppRoutes.loginRoute),
          // SizedBox(height: 16,),
        ],
      ),
    );
  }
}
