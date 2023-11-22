import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:lottie/lottie.dart';
import 'package:notjust_hack/commons/views/widgets/buttons.dart';
import 'package:notjust_hack/commons/views/widgets/fields.dart';
import 'package:notjust_hack/feature/authentication/controller/auth_controller.dart';
import 'package:notjust_hack/models/user.dart';
import 'package:notjust_hack/res/themes.dart';
import 'package:notjust_hack/utils/location_service.dart';

class BusinessRegisterForm extends ConsumerStatefulWidget {
  const BusinessRegisterForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BusinessRegisterFormState();
}

class _BusinessRegisterFormState extends ConsumerState<BusinessRegisterForm> {
  final businessNameCtrl = TextEditingController();
  final businessDescCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  GeoPoint location = const GeoPoint(0, 0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: LocationService().determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          location = GeoPoint(snapshot.data!.latitude, snapshot.data!.longitude);
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppFieldCommon(
                  controller: businessNameCtrl,
                  text: "Business Name",
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
                  height: 20,
                ),
                AppFieldCommon(
                  controller: businessDescCtrl,
                  text: "Business Description",
                  maxlines: 7,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Where can we find you?',
                    style: GoogleFonts.aleo(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: FlutterLocationPicker(
                      showZoomController: false,
                      showSearchBar: false,
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/edisonmodesto/cloqk3p9w005n01r61k0zfs1e/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZWRpc29ubW9kZXN0byIsImEiOiJjbGRlMzVqbnEwOW82M3BrNmNqdzI4Mm9kIn0.NCO-_8zS4SPhzFa0YNTyPw",
                      selectLocationButtonWidth: 200,
                      selectLocationButtonStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors().primary),
                      ),
                      selectedLocationButtonTextstyle: GoogleFonts.aleo(
                        color: AppColors().white,
                        fontSize: 14,
                      ),
                      initZoom: 11,
                      minZoomLevel: 5,
                      maxZoomLevel: 16,
                      trackMyPosition: true,
                      onPicked: (pickedData) {
                        location = GeoPoint(pickedData.latLong.latitude, pickedData.latLong.longitude);
                      },
                    ),
                  ),
                ),
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
                        firstName: "",
                        lastName: "",
                        profilePhoto: "",
                        coverPhoto: "https://picsum.photos/seed/picsum/200/200",
                        businessName: businessNameCtrl.text,
                        businessDescription: businessDescCtrl.text,
                        businessImages: [],
                        location: location,
                        type: "business",
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
