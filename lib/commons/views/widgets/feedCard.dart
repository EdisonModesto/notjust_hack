import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/utils/geocoding_service.dart';

class FeedCard extends ConsumerStatefulWidget {
  FeedCard({
    super.key,
    this.ontap,
    required this.image,
    required this.description,
    required this.title,
    required this.location,
  });

  final VoidCallback? ontap;
  String image;
  String title;
  String description;
  GeoPoint location;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscoverCardState();
}

class _DiscoverCardState extends ConsumerState<FeedCard> {
  @override
  Widget build(BuildContext context) {
    //random number
    final index = Random().nextInt(100);

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Card(
        child: InkWell(
          onTap: widget.ontap,
          child: SizedBox(
            height: 190,
            child: Row(
              children: [
                Expanded(
                  flex: 16,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    height: 190,
                  ),
                ),
                Expanded(
                  flex: 25,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aleo(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: GoogleFonts.aleo(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: FutureBuilder(
                                future: GeocodingService().getAddressFromGeoPoint(widget.location),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.aleo(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    );
                                  }
                                  return Text(
                                    '...',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aleo(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
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
