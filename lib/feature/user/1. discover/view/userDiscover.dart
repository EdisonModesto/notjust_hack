import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/views/widgets/feedCard.dart';
import 'package:notjust_hack/commons/views/widgets/loading.dart';
import 'package:notjust_hack/feature/user/1.%20discover/riverpod/all_business_provider.dart';

class UserDiscover extends ConsumerStatefulWidget {
  const UserDiscover({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserDiscoverState();
}

class _UserDiscoverState extends ConsumerState<UserDiscover> {
  @override
  Widget build(BuildContext context) {
    final businesses = ref.watch(businessesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discover',
          style: GoogleFonts.aleo(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: businesses.when(
            data: (data) {
              return ListView.separated(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FeedCard(
                    image: data[index].coverPhoto ?? '',
                    description: data[index].businessDescription ?? '',
                    title: data[index].businessName ?? '',
                    location: data[index].location ?? const GeoPoint(0, 0),
                    ontap: () {
                      GoRouter.of(context).pushNamed(
                        'discoverDetails',
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
            error: (error, stackTrace) {
              return Center(child: Text(error.toString()));
            },
            loading: () {
              return const CustomLoader();
            },
          ),
        )
      ],
    );
  }
}
