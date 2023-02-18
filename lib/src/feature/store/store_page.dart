import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../models/plant_model.dart';
import 'store_bloc.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreBloc(),
      child: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Item Details'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.read<StoreBloc>().controller.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
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
                          onPressed: () {
                            context.read<StoreBloc>().controller.nextPage(
                                duration: const Duration(milliseconds: 500),
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
                      onPressed: () => context
                          .read<StoreBloc>()
                          .add(context, stores[state.currentPageIndex]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "ADD PLANT",
                            style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ))
                ],
              ));
        },
      ),
    );
  }
}
