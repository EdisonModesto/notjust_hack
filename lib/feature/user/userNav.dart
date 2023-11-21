import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/feature/user/1.%20discover/view/userDiscover.dart';
import 'package:notjust_hack/feature/user/2.%20events/view/userEvents.dart';
import 'package:notjust_hack/feature/user/3.%20scanner/view/userScanner.dart';
import 'package:notjust_hack/feature/user/4.%20community/view/userCommunity.dart';
import 'package:notjust_hack/feature/user/5.%20profile/view/userProfile.dart';
import 'package:notjust_hack/res/themes.dart';

import '../../commons/providers/fire_auth_provider.dart';
import '../../commons/providers/user_data_provider.dart';
import '../../utils/logger.dart';
import '../authentication/view/auth_view.dart';

class UserNav extends ConsumerStatefulWidget {
  const UserNav({super.key});

  static const routePath = "/user";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<UserNav> {
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    ref.listen(
      userIdProvider,
      (previous, next) {
        if (next.value != null) {
          Log().info("User is logged in");
        } else {
          Log().info("User is not logged in");
          GoRouter.of(context).pushReplacement(AuthView.routePath);
        }
      },
    );

    final userData = ref.watch(userDataProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: IndexedStack(
          index: currIndex,
          children: const [
            UserDiscover(),
            UserEvents(),
            UserScanner(),
            UserCommunity(),
            UserProfile(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: NavigationBar(
                backgroundColor: Colors.white,
                elevation: 4,
                selectedIndex: currIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    currIndex = index;
                  });
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.looks),
                    label: "Discover",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.event),
                    label: "Events",
                  ),
                  NavigationDestination(
                    icon: SizedBox(),
                    label: "",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.people_alt_outlined),
                    label: "Community",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 15),
        child: FloatingActionButton(
          onPressed: () {
            currIndex = 2;
            setState(() {});
          },
          elevation: 0,
          backgroundColor: AppColors().primary,
          foregroundColor: AppColors().white,
          child: const Icon(
            Icons.qr_code_scanner_outlined,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
