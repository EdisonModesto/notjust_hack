import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCommunity extends ConsumerStatefulWidget {
  const UserCommunity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserCommunityState();
}

class _UserCommunityState extends ConsumerState<UserCommunity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Posts Nearby',
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
              return const Card(
                child: SizedBox(
                  height: 250,
                ),
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
