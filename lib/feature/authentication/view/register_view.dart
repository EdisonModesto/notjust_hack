import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/providers/fire_auth_provider.dart';
import 'package:notjust_hack/commons/providers/user_data_provider.dart';
import 'package:notjust_hack/feature/authentication/view/login_view.dart';
import 'package:notjust_hack/feature/authentication/view/widgets/business_register_form.dart';
import 'package:notjust_hack/feature/authentication/view/widgets/user_register_form.dart';
import 'package:notjust_hack/feature/user/userNav.dart';
import 'package:notjust_hack/res/strings.dart';
import 'package:notjust_hack/utils/logger.dart';

class RegisterView extends ConsumerStatefulWidget {
  RegisterView({super.key, required this.type});

  String type;

  static const String routePath = '/register-view/:type';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next.value != null) {
        if (next.value!.type == "user") {
          GoRouter.of(context).pushReplacement(UserNav.routePath);
        } else if (next.value!.type == "business") {
          GoRouter.of(context).pushReplacement(UserNav.routePath);
        }
      }
    });

    ref.listen(
      userIdProvider,
      (previous, next) {
        if (next.value != null) {
          Log().info("User is logged in");
        } else {
          Log().info("User is not logged in");
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(35),
          width: double.infinity,
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome to\n${AppStrings.appName}",
                      style: GoogleFonts.aleo(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  widget.type == "business" ? const BusinessRegisterForm() : const UserRegisterForm(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: GoogleFonts.aleo(
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              GoRouter.of(context).push(LoginView.routePath);
                            },
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
