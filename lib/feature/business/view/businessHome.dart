import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/providers/fire_auth_provider.dart';
import 'package:notjust_hack/commons/providers/user_data_provider.dart';
import 'package:notjust_hack/commons/views/widgets/appBar.dart';
import 'package:notjust_hack/commons/views/widgets/feedCard.dart';
import 'package:notjust_hack/res/themes.dart';
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
                  const FeedCard(),
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

                        screenshotController.captureAndSave(directory).then((image) {
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
                  )
                ],
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
