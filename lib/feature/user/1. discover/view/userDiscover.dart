import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/views/widgets/feedCard.dart';

class UserDiscover extends ConsumerStatefulWidget {
  const UserDiscover({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserDiscoverState();
}

class _UserDiscoverState extends ConsumerState<UserDiscover> {
  @override
  Widget build(BuildContext context) {
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
          child: ListView.separated(
            itemCount: 100,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FeedCard(
                ontap: () {
                  GoRouter.of(context).pushNamed(
                    'discoverDetails',
                    pathParameters: {
                      'imageUrl': 'https://picsum.photos/seed/${index * 100}/200/200',
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
          ),
        )
      ],
    );
  }
}
