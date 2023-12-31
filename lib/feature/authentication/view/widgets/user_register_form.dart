import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notjust_hack/models/user.dart';
import 'package:notjust_hack/utils/location_service.dart';

import '../../../../commons/views/widgets/buttons.dart';
import '../../../../commons/views/widgets/fields.dart';
import '../../../../res/themes.dart';
import '../../controller/auth_controller.dart';

class UserRegisterForm extends ConsumerStatefulWidget {
  const UserRegisterForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<UserRegisterForm> {
  final firstCtrl = TextEditingController();
  final lastCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: LocationService().determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data!.latitude.toString());
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppFieldCommon(
                        controller: firstCtrl,
                        text: "First Name",
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: AppFieldCommon(
                        controller: lastCtrl,
                        text: "Last Name",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AppFieldEmail(controller: emailCtrl),
                const SizedBox(
                  height: 20,
                ),
                AppFieldPassword(controller: passwordCtrl),
                const SizedBox(
                  height: 50,
                ),
                AppButtonFlat(
                  bgColor: AppColors().primary,
                  fgColor: AppColors().white,
                  text: "Signup",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final auth = ref.watch(authControllerProvider);
                      UserModel user = UserModel(
                        email: emailCtrl.text,
                        firstName: firstCtrl.text,
                        lastName: lastCtrl.text,
                        profilePhoto: "https://picsum.photos/seed/picsum/200/200",
                        coverPhoto: "",
                        businessName: "",
                        businessDescription: "",
                        businessImages: [],
                        location: GeoPoint(snapshot.data!.latitude, snapshot.data!.longitude),
                        type: "user",
                      );
                      auth.signUpEmail(emailCtrl.text, passwordCtrl.text, user);
                    }
                  },
                ),
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return Center(
          child: Column(
            children: [
              Lottie.asset(
                'assets/animations/loading.json',
                height: 200,
              ),
              Text(
                'Getting Location...',
                style: GoogleFonts.aleo(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
