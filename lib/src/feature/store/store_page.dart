import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';
import 'package:plant_notification/src/widgets/button.dart';
import '../../models/plant_model.dart';
import 'store_bloc.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  static const routeName = '/store_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreBloc(),
      child: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(title: const Text('Store')),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () =>
                              context.read<StoreBloc>().onArrowBack(),
                          icon: const Icon(Icons.arrow_back)),
                      Expanded(
                        child: SizedBox(
                          height: 200.h,
                          child: PageView(
                              onPageChanged: (index) => context
                                  .read<StoreBloc>()
                                  .onPageChanged(index),
                              pageSnapping: true,
                              allowImplicitScrolling: true,
                              controller: context.read<StoreBloc>().controller,
                              physics: const BouncingScrollPhysics(),
                              children: stores
                                  .map((e) => Lottie.asset(e.image))
                                  .toList()),
                        ),
                      ),
                      IconButton(
                          onPressed: () =>
                              context.read<StoreBloc>().onArrowForward(),
                          icon: const Icon(Icons.arrow_forward)),
                    ],
                  ),
                  XButton(
                    icon: Icons.add,
                    label: 'ADD PLANT',
                    onPressed: () => context
                        .read<StoreBloc>()
                        .add(context, stores[state.currentPageIndex]),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
