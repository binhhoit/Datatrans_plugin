import 'package:flutter/material.dart';

import 'package:datatrans_plugin_flutter/datatrans_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _datatransFlutterPlugin = DatatransPluginFlutter();

  @override
  void initState() {
    super.initState();
    _datatransFlutterPlugin.initialize("", "");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: InkWell(
            onTap:() {
              var params = PaymentParams(
                amount: 1000, 
                currency: "USD", 
                paymentMethods: [
                  PaymentMethodType.masterCard.rawValue,
                  PaymentMethodType.visa.rawValue
                ]);
              _datatransFlutterPlugin.payment(params: params);
            },
            child: const Text('Charge payment'),
          ),
        ),
      ),
    );
  }
}
