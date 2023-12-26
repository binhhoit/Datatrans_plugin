import 'package:flutter/cupertino.dart';
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
    _datatransFlutterPlugin.initialize("1110015614", "NvhOGev4xmiWesTg");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(_datatransFlutterPlugin),
    );
  }
}

class Home extends StatelessWidget {
  final DatatransPluginFlutter _datatransFlutterPlugin;

  SavedPaymentParams? _savedPaymentParams;

  Home(DatatransPluginFlutter datatransFlutterPlugin, {super.key}) : _datatransFlutterPlugin = datatransFlutterPlugin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Charge payment'),
                onPressed: () async {
                  var params = PaymentParams(
                    amount: 1000,
                    currency: "USD",
                    saveAlias: true,
                    paymentMethods: [
                      PaymentMethodType.masterCard,
                      PaymentMethodType.visa,
                      PaymentMethodType.jcb,
                      PaymentMethodType.paypal,
                      PaymentMethodType.americanExpress
                    ]);
                  var success = await _datatransFlutterPlugin.payment(params: params);
                  if (success?.success ?? false) {
                    _savedPaymentParams = success?.data;
                    _showMyDialog(context, success?.success ?? false);
                  }
                },
              ),
              const SizedBox(height: 50,),
              ElevatedButton(
                child: const Text('Charge fast payment'),
                onPressed: () async {
                  var params = PaymentParams(
                    amount: 100,
                    currency: "USD",
                    autoSettle: true,
                    paymentMethods: _savedPaymentParams != null ? [_savedPaymentParams!.paymentMethod] : []);

                  if (_savedPaymentParams != null) {
                    var success = await _datatransFlutterPlugin.fastPayment(params: params, saveParams: _savedPaymentParams!);
                    if (success?.success ?? false) {
                      _showMyDialog(context, success?.success ?? false);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      );
  }

  void _showMyDialog(BuildContext context, bool success) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Payment is ${success ? 'successed' : 'not successed'}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
