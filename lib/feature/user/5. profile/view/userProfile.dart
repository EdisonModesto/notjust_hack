import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/providers/user_data_provider.dart';
import 'package:notjust_hack/commons/views/widgets/loading.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider);

    return user.when(
      data: (data) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                  data.profilePhoto ?? '',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${data.firstName} ${data.lastName}",
                style: GoogleFonts.aleo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  fixedSize: const Size(120, 40),
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Logout',
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CustomLoader(),
    );
  }
}
