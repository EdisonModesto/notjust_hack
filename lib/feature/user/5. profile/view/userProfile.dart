import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          const CircleAvatar(
            radius: 52,
            backgroundImage: NetworkImage(
              'https://picsum.photos/seed/picsum/200/200',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Edison Modesto',
            style: GoogleFonts.aleo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const ListTile(
            leading: Icon(
              Icons.location_on_outlined,
            ),
            title: Text('Location Range', style: TextStyle()),
            subtitle: Text(
              'Edit your range here',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.info_outline,
            ),
            title: Text('About App', style: TextStyle()),
            subtitle: Text(
              'View list of features',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          const Spacer(),
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
  }
}
