import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends ConsumerStatefulWidget {
  const CustomLoader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends ConsumerState<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/loading.json',
            height: 200,
          ),
          Text(
            'Loading...',
            style: GoogleFonts.aleo(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
