import 'package:albisharaa/ui/shared/colors.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:flutter/material.dart';

class CustomCont extends StatefulWidget {
  const CustomCont({
    super.key,
    required this.text,
    // this.ontap
  });
  final String text;
  // final Function? ontap;
  @override
  State<CustomCont> createState() => _CustomContState();
}

class _CustomContState extends State<CustomCont> {
  @override
  Widget build(BuildContext context) {
    return
        // onTap: () {
        //   if (widget.ontap != null) widget.ontap!();
        // },
        // child:
        Container(
            height: screenHieght(17),
            width: screenWidth(1.5),
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 159, 77, 47)),
            child: Center(
              child: Text(widget.text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth(22),
                      color: AppColors.mainBackColor)),
            ));
  }
}
