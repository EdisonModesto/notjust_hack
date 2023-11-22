import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/views/widgets/feedCard.dart';
import 'package:notjust_hack/commons/views/widgets/loading.dart';
import 'package:notjust_hack/feature/user/2.%20events/riverpod/eventsProvider.dart';
import 'package:notjust_hack/feature/user/2.%20events/view/screens/addEvents.dart';

class UserEvents extends ConsumerStatefulWidget {
  const UserEvents({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserEventsState();
}

class _UserEventsState extends ConsumerState<UserEvents> {
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);

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
              onPressed: () {
                GoRouter.of(context).push(AddEvents.routePath);
              },
              icon: const Icon(
                Icons.add,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
            child: events.when(
          data: (data) {
            return ListView.separated(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return FeedCard(
                  image: data[index].image ?? '',
                  description: data[index].description ?? '',
                  title: data[index].name ?? '',
                  location: data[index].location ?? const GeoPoint(0, 0),
                  ontap: () {
                    GoRouter.of(context).pushNamed(
                      'eventDetails',
                      pathParameters: {
                        'id': data[index].id.toString(),
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
            );
          },
          error: (error, stack) {
            return Center(child: Text(error.toString()));
          },
          loading: () {
            return const CustomLoader();
          },
        ))
      ],
    );
  }
}
