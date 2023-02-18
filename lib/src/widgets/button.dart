import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class XButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final IconData icon;
  const XButton(
      {super.key, required this.label, this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            SizedBox(
              width: 10.w,
            ),
            Text(
              label,
              style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
