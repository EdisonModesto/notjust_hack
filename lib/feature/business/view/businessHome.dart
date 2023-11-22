import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:notjust_hack/commons/providers/fire_auth_provider.dart';
import 'package:notjust_hack/commons/providers/user_data_provider.dart';
import 'package:notjust_hack/commons/views/widgets/appBar.dart';
import 'package:notjust_hack/commons/views/widgets/feedCard.dart';
import 'package:notjust_hack/feature/authentication/view/login_view.dart';
import 'package:notjust_hack/res/themes.dart';
import 'package:notjust_hack/utils/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class BusinessHome extends ConsumerStatefulWidget {
  const BusinessHome({super.key});

  static const String routePath = '/business/home';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BusinessHomeState();
}

class _BusinessHomeState extends ConsumerState<BusinessHome> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userIdProvider,
      (previous, next) {
        if (next.value != null) {
          Log().info("User is logged in");
        } else {
          Log().info("User is not logged in");
          GoRouter.of(context).pushReplacement(LoginView.routePath);
        }
      },
    );

    final userData = ref.watch(userDataProvider);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: userData.when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Business',
                      style: GoogleFonts.aleo(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FeedCard(
                      title: data.businessName ?? '',
                      description: data.businessDescription ?? '',
                      image: data.coverPhoto ?? '',
                      location: data.location ?? const GeoPoint(0, 0),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Your QR Code',
                      style: GoogleFonts.aleo(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Screenshot(
                        controller: screenshotController,
                        child: Card(
                          child: Container(
                            width: 250,
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 165,
                                    width: 165,
                                    child: QrImageView(
                                      data: 'business:${ref.read(userIdProvider).value!}',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    data.businessName ?? '',
                                    style: GoogleFonts.aleo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Visit us now!',
                                    style: GoogleFonts.aleo(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final directory = (await getApplicationDocumentsDirectory()).path; //from path_provide package

                          screenshotController.capture().then((image) async {
                            ImageGallerySaver.saveImage(
                              image!,
                            );
                            Fluttertoast.showToast(msg: 'QR Code saved to gallery');
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors().primary,
                          foregroundColor: AppColors().white,
                        ),
                        child: const Text(
                          'Download QR Code',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          FirebaseAuth.instance.signOut();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: AppColors().white,
                        ),
                        child: const Text(
                          'Logout',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text(error.toString()));
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
