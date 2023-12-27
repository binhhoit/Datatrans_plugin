# datatrans_plugin_flutter

A new Flutter Datatrans plugin project.

**IMPORTANT NOTES**:
- This plugin requires apps to be using IOS CocoaPods begin 1.13.0 or above.
- This plugin requires AndroidX SDK min 26.0 or above.

## Tutorials from identity providers
* [Datatrans](https://docs.datatrans.ch/docs/mobile-sdk)

## Getting Started
This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


The first step is to create an instance of the plugin

```
DatatransPluginFlutter plugin = DatatransPluginFlutter();
```

Firstly, you must initialize an object DatatransPluginFlutter. Afterwards, login to WebServer of Datatrans to create your session ID.

```dart
    plugin.initialize("merchant_id", "password", isTesting: false, appCallbackScheme: your_custom_scheme);
```

Here the `<merchant_id>` and `<password>` should be replaced by the values registered with your identity info on your Datatrans Account. Which user use for getting payment by Datatrans service (Can find it in admin page `https://admin.sandbox.datatrans.com`). The `<isTesting>` would be the BOOLEAN for the testing - simulate the payment without spent money. The `<your_custom_scheme>` is your urlScheme call back to app.

### Payment

To charging your payment. You must create a transaction with the following parameters of PaymentParams with value `<amount>` is your money amount, `<currency>` is nation currency unit, `<paymentMethods>` is your method of cards you want to pay (e.g. `masterCard`, `visa`, `paypal`, etc.).

Here the `<saveAlias>` is a parameter options for save info of payment with a key alias ( sercurity ). The parameter will be used for the one-touch payment without enter the information of payment in next time. This value have default options is OFF.

```dart
final params = PaymentParams(
                    amount: 1000,
                    currency: "USD",
                    saveAlias: false,
                    autoSettle: false,
                    paymentMethods: [
                      PaymentMethodType.masterCard,
                      PaymentMethodType.visa,
                    ]);
```

After creating the PaymentParams for each transaction payment. Finally, execute the following command to charging the reception.

```dart
var result = await plugin.payment(params: params);
```

Upon completing the request successfully, if you set the `<saveAlias>` is on, the method will return an object (the `<savedPaymentParams>` variable in the below sample code is an instance of the `SavedPaymentParams` class) that contain details that should be stored.

```dart
SavedPaymentParams savedPaymentParams = SavedPaymentParams();
```

If you would prefer to not set `<saveAlias>`. Will received an empty value.

### Fast Payment

Another options payment is Fast Payment or one-touch payment. This method required the `<saveParams>` with instance of the `SavedPaymentParams` class as user saved.

```dart
var result = await _datatransFlutterPlugin.fastPayment(params: params,
                                                       saveParams: saveParams);
                    
```

Reusing the nonce and code verifier is particularly important as the Datatrans SDKs (especially on Android) may return an error object (e.g.transaction failed, login falied, etc.) if this is have crashing.


## Android setup

The redirect URI can be directly replace `<your_custom_scheme>` by adding an
intent-filter for AppAuth's RedirectUriReceiverActivity to your
AndroidManifest.xml:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="com.example.my_app">
...
<activity
    android:name="ch.datatrans.payment.ExternalProcessRelayActivity"
    android:launchMode="singleTask"
    android:enabled="false"
    android:theme="@android:style/Theme.Translucent.NoTitleBar"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="<your_custom_scheme>.dtsdk" />
    </intent-filter>
</activity>
...
```

Please ensure that value of `<your_custom_scheme>` is all in lowercase as there've been reports from the community who had issues with redirects if there were any capital letters. You may also notice the `+=` operation is applied on `manifestPlaceholders` instead of `=`. This is intentional and required as newer versions of the Flutter SDK has made some changes underneath the hood to deal with multidex. Using `=` instead of `+=` can lead to errors like the following

```
Attribute application@name at AndroidManifest.xml:5:9-42 requires a placeholder substitution but no value for <applicationName> is provided.
```

If you see this error then update your `build.gradle` to use `+=` instead.

## iOS/macOS setup

Go to the `Info.plist` for your iOS/macOS app to specify the custom scheme so that there should be a section in it that look similar to the following but replace `<your_custom_scheme>` with the desired value


```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string><your_custom_scheme></string>
        </array>
    </dict>
</array>
```

## FAQs

Any problem please contact via email:
    thienvu2@saigontechnology.com
    binh.hothanh@saigontechnology.com
