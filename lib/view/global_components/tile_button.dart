import 'package:cocoa_master/view/utils/style.dart';
import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  final String? label;
  final Widget icon;
  final Color? backgroundColor;
  final Color? foreColor;
  final double? width;
  final double? height;
  final Function? onTap;
  const TileButton(
      {Key? key,
      required this.label,
      required this.icon,
      this.backgroundColor,
      this.foreColor,
      required this.onTap,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor ?? AppColor.primary,
        elevation: 0.5,
        // minimumSize: const Size(0, 36),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppBorderRadius.sm))),
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: () => onTap!(),
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              // const SizedBox(height: 8),
              Text(
                label!,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: foreColor ?? Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TileButtonDetached extends StatelessWidget {
  final Widget icon;
  final Function onTap;

  const TileButtonDetached({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.purple,
        backgroundColor: Colors.white10,
        // minimumSize: const Size(0, 36),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppButtonProps.borderRadius))),
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: () => onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Calculate Area',
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Calculate the area',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      softWrap: true,
                    ),
                    Text(
                      'of any farm and save its details',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      softWrap: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
