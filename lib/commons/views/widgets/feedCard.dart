import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/res/strings.dart';

class FeedCard extends ConsumerStatefulWidget {
  const FeedCard({super.key, this.ontap});

  final VoidCallback? ontap;

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
                    'https://picsum.photos/seed/${index * 100}/200/200',
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
                          'Johns Eatery',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aleo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppStrings.dummyLong,
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
                            Text(
                              '123 Main St',
                              style: GoogleFonts.aleo(
                                fontSize: 12,
                                color: Colors.black,
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
