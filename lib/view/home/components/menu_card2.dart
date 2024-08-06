import 'package:cocoa_master/view/utils/style.dart';
import 'package:flutter/material.dart';

class MenuCard2 extends StatelessWidget {
  final String image;
  final String label;
  final Function onTap;
  const MenuCard2(
      {Key? key, required this.image, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String hexColor = "#895937";
    String hexColor2 = "#f0ded0";
    // Color nudeBrown =
    //     Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
    Color nudeBrown2 =
        Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);

    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(AppButtonProps.borderRadius),
          boxShadow: [
            BoxShadow(
              color: nudeBrown2, //color of shadow
              spreadRadius: 2, //spread radius
              blurRadius: 5, // blur radius
              offset: const Offset(3, 3),
            ),
          ]),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: nudeBrown2,
          backgroundColor: Colors.white10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppButtonProps.borderRadius))),
          // splashFactory: NoSplash.splashFactory,
        ),
        onPressed: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Image.asset(image, height: 40),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
