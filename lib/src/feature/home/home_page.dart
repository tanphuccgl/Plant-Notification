import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_notification/src/feature/account/account_bloc.dart';
import 'package:plant_notification/src/feature/home/empty_plant_page.dart';
import 'package:plant_notification/src/feature/plant/water_level_bloc.dart';
import 'package:plant_notification/src/feature/plant/water_level_indicator.dart';
import 'package:plant_notification/src/feature/notification/notification_bloc.dart';
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
        builder: (context, homeState) {
          return BlocBuilder<AccountBloc, AccountState>(
            buildWhen: (p, c) =>
                p.user != c.user || p.plantsIsEmpty != c.plantsIsEmpty,
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
                    :  BlocBuilder<AccountBloc, AccountState>(
            buildWhen: (p, c) =>
                p.user != c.user ,
            builder: (context, acccountState) {
              final item = acccountState.plants[homeState.currentPageIndex];

                          return BlocProvider(
                            create: (context) => WaterLevelBloc(item.id,
                                WaterLevelState(waterLevel: item.humidity)),
                            child: BlocBuilder<WaterLevelBloc, WaterLevelState>(
                              builder: (context, humidityState) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        acccountState.hasOnlyOne
                                            ? const SizedBox.shrink()
                                            : IconButton(
                                                onPressed: () => context
                                                    .read<HomeBloc>()
                                                    .onArrowBack(),
                                                icon: const Icon(
                                                    Icons.arrow_back)),
                                        Expanded(
                                          child: SizedBox(
                                            height: 200.h,
                                            child: PageView(
                                                onPageChanged: (index) =>
                                                    context
                                                        .read<HomeBloc>()
                                                        .onPageChanged(index),
                                                pageSnapping: true,
                                                allowImplicitScrolling: true,
                                                controller: context
                                                    .read<HomeBloc>()
                                                    .controller,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                children: acccountState.plants
                                                    .map((e) =>
                                                        Lottie.asset(e.image))
                                                    .toList()),
                                          ),
                                        ),
                                        acccountState.hasOnlyOne
                                            ? const SizedBox.shrink()
                                            : IconButton(
                                                onPressed: () => context
                                                    .read<HomeBloc>()
                                                    .onArrowForward(),
                                                icon: const Icon(
                                                    Icons.arrow_forward)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    WaterLevelIndicator(
                                      waterLevel: item.humidity,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    BlocBuilder<NotificationBloc,
                                        NotificationState>(
                                      builder: (context, state) {
                                        return XButton(
                                          label: 'WATER',
                                          onPressed: () => context
                                              .read<WaterLevelBloc>()
                                              .onTapWater(),
                                          icon: Icons.water,
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
