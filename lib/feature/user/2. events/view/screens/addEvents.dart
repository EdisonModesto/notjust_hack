import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:notjust_hack/commons/views/widgets/buttons.dart';
import 'package:notjust_hack/commons/views/widgets/fields.dart';
import 'package:notjust_hack/models/event.dart';
import 'package:notjust_hack/res/themes.dart';
import 'package:notjust_hack/utils/cloud_storage_service.dart';

class AddEvents extends ConsumerStatefulWidget {
  const AddEvents({super.key});

  static const routePath = '/addEvents';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddEventsState();
}

class _AddEventsState extends ConsumerState<AddEvents> {
  final businessNameCtrl = TextEditingController();
  final businessDescCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  GeoPoint location = const GeoPoint(0, 0);

  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Event',
                  style: GoogleFonts.aleo(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppFieldCommon(
                  controller: businessNameCtrl,
                  text: "Event Name",
                ),
                const SizedBox(
                  height: 20,
                ),
                AppFieldCommon(
                  controller: businessDescCtrl,
                  text: "Event Description",
                  maxlines: 7,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Cover Photo',
                    style: GoogleFonts.aleo(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                    );
                    setState(() {});
                  },
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    child: result == null
                        ? const Center(
                            child: Text('No image selected'),
                          )
                        : Image.file(
                            File(result!.files.single.path!),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Where will your event be?',
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
                  text: "Add Event",
                  onTap: () async {
                    if (formKey.currentState!.validate() && location != const GeoPoint(0, 0) && result != null) {
                      String urlId = await CloudService().uploadImage(result!);
                      EventModel newEvent = EventModel(
                        name: businessNameCtrl.text,
                        description: businessDescCtrl.text,
                        image: urlId,
                        location: location,
                      );
                      await FirebaseFirestore.instance.collection('Events').add(newEvent.toJson());
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(msg: "Please fill in all the fields");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
