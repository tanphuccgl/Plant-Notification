import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_notification/src/feature/store/store_page.dart';

class EmptyPlantPage extends StatelessWidget {
  const EmptyPlantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
            onPressed: () =>
                Navigator.restorablePushNamed(context, StorePage.routeName),
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
                  style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                )
              ],
            ))
      ],
    ));
  }
}
