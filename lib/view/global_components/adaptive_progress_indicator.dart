import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const Center(
        child: CupertinoActivityIndicator(
          radius: 22.0,
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class TinyLoader extends StatelessWidget {
  const TinyLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  const [
           CupertinoActivityIndicator(
            radius: 10.0,
          ),
          Text(
            'Waiting for network',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
