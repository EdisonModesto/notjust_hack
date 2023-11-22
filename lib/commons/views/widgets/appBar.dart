import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/views/screens/MapView.dart';
import 'package:notjust_hack/res/themes.dart';

class CustomAppBar extends ConsumerStatefulWidget {
  const CustomAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            const Icon(
              Icons.wb_sunny_outlined,
              color: Colors.black,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              'Good Morning!',
              style: GoogleFonts.aleo(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(MapView.routePath);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors().primary.withOpacity(0.8),
                foregroundColor: AppColors().white,
                elevation: 0,
              ),
              child: Row(
                children: [
                  const Icon(Icons.map_outlined),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Map",
                    style: GoogleFonts.aleo(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
