import 'package:flutter/material.dart';

import 'package:datatrans_plugin_flutter/datatrans_plugin_flutter.dart';

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
    _datatransFlutterPlugin.initialize("1110015614", "NvhOGev4xmiWesTg", isTesting: true, appCallbackScheme: 'app.datatrans.flutter');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(datatransFlutterPlugin: _datatransFlutterPlugin),
    );
  }
}

class Home extends StatefulWidget {
  final DatatransPluginFlutter datatransFlutterPlugin;

  const Home({super.key, required this.datatransFlutterPlugin});

  @override
  State<Home> createState() => HomeState();

}

class HomeState extends State<Home> {
  SavedPaymentParams? _savedPaymentParams;

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
                  var result = await widget.datatransFlutterPlugin.payment(params: params);
                  _showMyDialog(context, result?.success ?? false, error: result?.error);
                  if (result?.success == true) {
                    _savedPaymentParams = result?.data;
                  } else{
                    print(result?.bodyError.toString());
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
                    var result = await widget.datatransFlutterPlugin.fastPayment(params: params, saveParams: _savedPaymentParams!);
                    _showMyDialog(context, result?.success ?? false, error: result?.error);
                  }
                },
              ),
            ],
          ),
        ),
      );
  }

  void _showMyDialog(BuildContext context, bool success, {String? error}) {
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
                if (error != null) Text(error),
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
