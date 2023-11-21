import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverDetails extends ConsumerStatefulWidget {
  DiscoverDetails({
    required this.imageUrl,
    super.key,
  });

  String imageUrl;

  static const String routePath = '/discover/details/:imageUrl';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscoverDetailsState();
}

class _DiscoverDetailsState extends ConsumerState<DiscoverDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            widget.imageUrl,
            width: double.infinity,
            height: 275,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Johns Eatery',
            style: GoogleFonts.aleo(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
