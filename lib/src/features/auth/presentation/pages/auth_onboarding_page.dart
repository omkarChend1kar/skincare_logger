import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skincare_logger/src/core/common/services/service_locator.dart';
import 'package:skincare_logger/src/core/common/themes/constants.dart';
import 'package:skincare_logger/src/core/utill/utills/utills.dart';
import 'package:skincare_logger/src/features/auth/presentation/cubit/auth_cubit.dart';

class AuthOnboardingPage extends StatefulWidget {
  const AuthOnboardingPage({super.key});

  @override
  State<AuthOnboardingPage> createState() => _AuthOnboardingPageState();
}

class _AuthOnboardingPageState extends State<AuthOnboardingPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isSignIn = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isPasswordHidden = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 247, 250),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Skincare Logger',
                  style: textStyle,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: isSignIn,
                          builder: (context, value, child) {
                            if (value) {
                              return AuthSigninFormWidget(
                                formKey: formKey,
                                emailController: emailController,
                                passwordController: passwordController,
                                isPasswordHidden: isPasswordHidden,
                                textStyle: textStyle,
                              );
                            } else {
                              return AuthCreateAccountFormWidget(
                                formKey: formKey,
                                emailController: emailController,
                                nameController: nameController,
                                passwordController: passwordController,
                                isPasswordHidden: isPasswordHidden,
                                textStyle: textStyle,
                              );
                            }
                          },
                        ),
                        const Divider(
                          height: 20,
                          thickness: 4,
                        ),
                        ElevatedButton.icon(
                          label: Text(
                            'Sign In',
                            style: textStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          icon: const FaIcon(FontAwesomeIcons.google),
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ),
                                ),
                              ),
                            ),
                            side: MaterialStatePropertyAll(BorderSide()),
                            minimumSize: MaterialStatePropertyAll(
                              Size(
                                double.maxFinite,
                                50,
                              ),
                            ),
                            foregroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 252, 247, 250),
                            ),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 150, 79, 101),
                            ),
                          ),
                          onPressed: () {},
                        ),
                        ValueListenableBuilder(
                            valueListenable: isSignIn,
                            builder: (context, value, _) {
                              return TextButton(
                                onPressed: () {
                                  isSignIn.value = !value;
                                },
                                child: Text(
                                  !value ? 'Sign In' : 'Create Account',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: const Color.fromARGB(
                                      255,
                                      150,
                                      79,
                                      101,
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthSigninFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final ValueNotifier<bool> isPasswordHidden;
  final TextStyle textStyle;
  const AuthSigninFormWidget({
    super.key,
    required this.textStyle,
    required this.isPasswordHidden,
    required this.passwordController,
    required this.emailController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) => sl<Utills>().emailValidator(
            emailValidation: "Please enter a valid email",
            value: value,
          ),
          controller: emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: "Email",
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ValueListenableBuilder<bool>(
            valueListenable: isPasswordHidden,
            builder: (context, ispasswordHidden, _) {
              return TextFormField(
                validator: (value) => sl<Utills>().passwordValidator(
                  passwordValidation: "Please enter a valid password",
                  value: value,
                ),
                controller: passwordController,
                obscureText: isPasswordHidden.value,
                decoration: InputDecoration(
                  suffixIcon: ValueListenableBuilder<bool>(
                    valueListenable: isPasswordHidden,
                    builder: (context, ispasswordHidden, _) {
                      return IconButton(
                        icon: Icon(
                          ispasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          isPasswordHidden.value = !ispasswordHidden;
                        },
                      );
                    },
                  ),
                  hintText: "Password",
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: const ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
            ),
            side: MaterialStatePropertyAll(BorderSide()),
            minimumSize: MaterialStatePropertyAll(
              Size(
                double.maxFinite,
                50,
              ),
            ),
            foregroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 252, 247, 250),
            ),
            backgroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 150, 79, 101),
            ),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<AuthCubit>().signIn(
                    email: emailController.text,
                    password: passwordController.text,
                  );
            }
          },
          child: Text(
            'Sign In',
            style: textStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class AuthCreateAccountFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final ValueNotifier<bool> isPasswordHidden;
  final TextStyle textStyle;

  const AuthCreateAccountFormWidget({
    super.key,
    required this.textStyle,
    required this.isPasswordHidden,
    required this.passwordController,
    required this.emailController,
    required this.nameController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          validator: (value) => sl<Utills>().miscValidator(
            nameValidation: "Please enter name, min length 2",
            value: value,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: "Name",
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: emailController,
          validator: (value) => sl<Utills>().emailValidator(
            emailValidation: "Please enter a valid email",
            value: value,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: "Email",
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ValueListenableBuilder(
            valueListenable: isPasswordHidden,
            builder: (context, value, _) {
              return TextFormField(
                controller: passwordController,
                validator: (value) => sl<Utills>().passwordValidator(
                  passwordValidation: "Please enter a valid password",
                  value: value,
                ),
                obscureText: isPasswordHidden.value,
                decoration: InputDecoration(
                  suffixIcon: ValueListenableBuilder<bool>(
                    valueListenable: isPasswordHidden,
                    builder: (context, ispasswordHidden, _) {
                      return IconButton(
                        icon: Icon(
                          ispasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          isPasswordHidden.value = !ispasswordHidden;
                        },
                      );
                    },
                  ),
                  hintText: "Password",
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: const ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
            ),
            side: MaterialStatePropertyAll(BorderSide()),
            minimumSize: MaterialStatePropertyAll(
              Size(
                double.maxFinite,
                50,
              ),
            ),
            foregroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 252, 247, 250),
            ),
            backgroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 150, 79, 101),
            ),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<AuthCubit>().createAccount(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
            }
          },
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthCreatedAccount) {
                context.read<AuthCubit>().checkSignInStatus();
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator.adaptive();
              }
              return Text(
                'Create Account',
                style: textStyle.copyWith(
                  fontSize: 16,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
