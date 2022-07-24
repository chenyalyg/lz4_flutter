import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:lz4_flutter/lz4_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _test = 'Failed';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }


  Future<void> initPlatformState() async {
    String test;

    try {
      var dst=await Lz4Flutter.lz4_encode(Uint8List.fromList([1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9]));
      var src=await Lz4Flutter.lz4_decode(dst!,36);

      test=src?.toString()??"Failed";
    } on PlatformException {
      test = 'Failed';
    }

    if (!mounted) return;

    setState(() {
      _test = test;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(' $_test\n'),
        ),
      ),
    );
  }
}
