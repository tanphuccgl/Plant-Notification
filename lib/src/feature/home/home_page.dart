import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_notification/src/feature/account/account_bloc.dart';
import 'package:plant_notification/src/feature/home/empty_plant_page.dart';
import 'package:plant_notification/src/widgets/button.dart';

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
        builder: (context, _) {
          return BlocBuilder<AccountBloc, AccountState>(
            builder: (context, acccountState) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Home'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.store),
                      onPressed: () =>
                          context.read<HomeBloc>().onStore(context),
                    ),
                  ],
                ),
                body: acccountState.plantsIsEmpty
                    ? const EmptyPlantPage()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      context.read<HomeBloc>().onArrowBack(),
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
                                      children: acccountState.plants
                                          .map((e) => Lottie.asset(e.image))
                                          .toList()),
                                ),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      context.read<HomeBloc>().onArrowForward(),
                                  icon: const Icon(Icons.arrow_forward)),
                            ],
                          ),
                          XButton(
                            label: 'WATER',
                            onPressed: () {},
                            icon: Icons.water,
                          ),
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
