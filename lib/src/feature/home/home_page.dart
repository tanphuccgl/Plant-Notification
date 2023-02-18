import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_notification/src/feature/account/account_bloc.dart';
import 'package:plant_notification/src/feature/store/store_page.dart';

import 'home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state1) {
          return BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Sample Items'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        // Navigate to the settings page. If the user leaves and returns
                        // to the app after it has been killed while running in the
                        // background, the navigation stack is restored.
                        Navigator.restorablePushNamed(
                            context, StorePage.routeName);
                      },
                    ),
                  ],
                ),
                body: state.user.plants.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/lotties/empty.json'),
                          SizedBox(
                            height: 30.h,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                              onPressed: () => Navigator.restorablePushNamed(
                                  context, StorePage.routeName),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.add),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "NEW PLANT",
                                    style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ))
                        ],
                      ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<HomeBloc>()
                                        .controller
                                        .previousPage(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut);
                                  },
                                  icon: const Icon(Icons.arrow_back)),
                              Expanded(
                                child: SizedBox(
                                  height: 200.h,
                                  child: PageView(
                                      onPageChanged: (index) => context
                                          .read<HomeBloc>()
                                          .onPageChanged(index),
                                      pageSnapping: true,
                                      allowImplicitScrolling: true,
                                      controller:
                                          context.read<HomeBloc>().controller,
                                      physics: const BouncingScrollPhysics(),
                                      children: state.plants
                                          .map((e) => Lottie.asset(e.image))
                                          .toList()),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<HomeBloc>()
                                        .controller
                                        .nextPage(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut);
                                  },
                                  icon: const Icon(Icons.arrow_forward)),
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.add),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "WATER",
                                    style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ))
                        ],
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
