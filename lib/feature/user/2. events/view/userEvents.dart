import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/views/widgets/feedCard.dart';

class UserEvents extends ConsumerStatefulWidget {
  const UserEvents({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserEventsState();
}

class _UserEventsState extends ConsumerState<UserEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Nearby Events',
              style: GoogleFonts.aleo(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_list_outlined,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 100,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FeedCard(
                image: 'https://picsum.photos/seed/${index * 100}/200/200',
                description: 'Event Description',
                title: 'Event Title',
                location: const GeoPoint(0, 0),
                ontap: () {},
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
          ),
        )
      ],
    );
  }
}
