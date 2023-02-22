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
    return BlocBuilder<NotificationBloc, NotificationState>(
      buildWhen: (p, c) => false,
      builder: (context, state) {
        return BlocBuilder<AccountBloc, AccountState>(
          buildWhen: (p, c) => p.user != c.user,
          builder: (context, accountState) {
            return BlocProvider(
                create: (_) => HomeBloc(),
                child: Scaffold(
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
                    body: accountState.plantsIsEmpty
                        ? const EmptyPlantPage()
                        : BlocBuilder<HomeBloc, HomeState>(
                            buildWhen: (p, c) =>
                                p.currentPageIndex != c.currentPageIndex,
                            builder: (context, homeState) {
                              final item = accountState
                                  .plants[homeState.currentPageIndex];

                              return BlocProvider(
                                  create: (context) => WaterLevelBloc(
                                      item.id,
                                      WaterLevelState(
                                          waterLevel: item.humidity)),
                                  child: BlocConsumer<WaterLevelBloc,
                                      WaterLevelState>(
                                    listener: (context, state) => context
                                        .read<WaterLevelBloc>()
                                        .pushNotificationLocal(),
                                    builder: (context, _) {
                                      return BlocBuilder<WaterLevelBloc,
                                          WaterLevelState>(
                                        buildWhen: (p, c) => false,
                                        builder: (context, humidityState) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  accountState.hasOnlyOne
                                                      ? const SizedBox.shrink()
                                                      : IconButton(
                                                          onPressed: () => context
                                                              .read<HomeBloc>()
                                                              .onArrowBack(),
                                                          icon: const Icon(Icons
                                                              .arrow_back)),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 200.h,
                                                      child: PageView(
                                                          onPageChanged:
                                                              (index) => context
                                                                  .read<
                                                                      HomeBloc>()
                                                                  .onPageChanged(
                                                                      index),
                                                          pageSnapping: true,
                                                          allowImplicitScrolling:
                                                              true,
                                                          controller: context
                                                              .read<HomeBloc>()
                                                              .controller,
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          children: accountState
                                                              .plants
                                                              .map((e) =>
                                                                  Lottie.asset(
                                                                      e.image))
                                                              .toList()),
                                                    ),
                                                  ),
                                                  accountState.hasOnlyOne
                                                      ? const SizedBox.shrink()
                                                      : IconButton(
                                                          onPressed: () => context
                                                              .read<HomeBloc>()
                                                              .onArrowForward(),
                                                          icon: const Icon(Icons
                                                              .arrow_forward)),
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
                                              XButton(
                                                label: 'WATER',
                                                onPressed: () => context
                                                    .read<WaterLevelBloc>()
                                                    .onTapWater(),
                                                icon: Icons.water,
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              XButton(
                                                label: 'SCHEDULE WATER',
                                                onPressed: () => context
                                                    .read<WaterLevelBloc>()
                                                    .onTapScheduleWater(),
                                                icon: Icons.water,
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ));
                            },
                          )));
          },
        );
      },
    );
  }
}
