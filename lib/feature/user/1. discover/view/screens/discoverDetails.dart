import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/views/screens/MapView2.dart';
import 'package:notjust_hack/commons/views/widgets/loading.dart';
import 'package:notjust_hack/feature/user/1.%20discover/riverpod/specific_business_provider.dart';
import 'package:notjust_hack/res/themes.dart';

class DiscoverDetails extends ConsumerStatefulWidget {
  DiscoverDetails({
    required this.id,
    super.key,
  });

  String id;

  static const String routePath = '/discover/details/:id';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscoverDetailsState();
}

class _DiscoverDetailsState extends ConsumerState<DiscoverDetails> {
  @override
  Widget build(BuildContext context) {
    final details = ref.watch(specificBusinessProvider(widget.id));
    return Scaffold(
      floatingActionButton: details.when(
        data: (data) {
          return FloatingActionButton(
            backgroundColor: AppColors().primary,
            foregroundColor: AppColors().white,
            tooltip: 'View on Map',
            onPressed: () {
              GoRouter.of(context).push(
                MapView2.routePath,
                extra: data.location,
              );
            },
            child: const Icon(
              Icons.map_outlined,
            ),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CustomLoader(),
      ),
      body: details.when(
        data: (data) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  data.coverPhoto ?? '',
                  width: double.infinity,
                  height: 275,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.businessName ?? '',
                        style: GoogleFonts.aleo(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Description:',
                        style: GoogleFonts.aleo(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        data.businessDescription ?? '',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.aleo(
                          fontSize: 16,
                          color: Colors.black.withOpacity(
                            0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return const CustomLoader();
        },
      ),
    );
  }
}
