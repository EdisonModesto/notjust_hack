import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notjust_hack/res/themes.dart';

class RegisterOptions extends ConsumerStatefulWidget {
  const RegisterOptions({super.key});

  static const String routePath = '/register/options';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterOptionsState();
}

class _RegisterOptionsState extends ConsumerState<RegisterOptions> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations/hello.json'),
              Text(
                "Greetings!\nLet's get you started",
                textAlign: TextAlign.center,
                style: GoogleFonts.aleo(
                  fontSize: 26,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Register as: ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aleo(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(20),
                  isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                  onPressed: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5 - 55,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('User')),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5 - 55,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('Business')),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    'register',
                    pathParameters: {'type': _selectedIndex == 0 ? 'user' : 'business'},
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors().primary,
                  foregroundColor: AppColors().white,
                  fixedSize: const Size(300, 50),
                ),
                child: Text(
                  "Continue",
                  style: GoogleFonts.aleo(),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
