import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:notjust_hack/commons/views/screens/MapView2.dart';
import 'package:notjust_hack/commons/views/widgets/loading.dart';
import 'package:notjust_hack/feature/user/2.%20events/riverpod/specificEventProvider.dart';
import 'package:notjust_hack/res/themes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class EventsDetail extends ConsumerStatefulWidget {
  EventsDetail({
    required this.id,
    super.key,
  });

  static const String routePath = '/events/details/:id';

  String id;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventsDetailState();
}

class _EventsDetailState extends ConsumerState<EventsDetail> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(specificEventProvider(widget.id));
    return Scaffold(
      floatingActionButton: details.when(
        data: (data) {
          return FloatingActionButton(
            backgroundColor: AppColors().primary,
            foregroundColor: AppColors().white,
            tooltip: 'View on Map',
            onPressed: () {
              GoRouter.of(context).push(
                MapView2.routePath,
                extra: data.location,
              );
            },
            child: const Icon(
              Icons.map_outlined,
            ),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CustomLoader(),
      ),
      body: details.when(
        data: (data) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  data.image ?? '',
                  width: double.infinity,
                  height: 275,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name ?? '',
                        style: GoogleFonts.aleo(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Description:',
                        style: GoogleFonts.aleo(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        data.description ?? '',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.aleo(
                          fontSize: 16,
                          color: Colors.black.withOpacity(
                            0.8,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          'Share this event via QR Code:',
                          style: GoogleFonts.aleo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Screenshot(
                          controller: screenshotController,
                          child: Card(
                            child: Container(
                              width: 225,
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 165,
                                      width: 165,
                                      child: QrImageView(
                                        data: 'event:${widget.id}',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      data.name ?? '',
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
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return const CustomLoader();
        },
      ),
    );
  }
}
