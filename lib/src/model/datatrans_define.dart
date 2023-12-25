enum DatatransMethodIdentity {
  initialize,
  saveCardPaymentInfo,
  payment,
  fastPayment
}

extension DatatransMethodIdentityExtend on DatatransMethodIdentity {
  String get methodName {
    switch (this) {
      case DatatransMethodIdentity.initialize:
        return 'initialize';
      case DatatransMethodIdentity.saveCardPaymentInfo:
        return 'saveCardPaymentInfo';
      case DatatransMethodIdentity.payment:
        return 'payment';
      case DatatransMethodIdentity.fastPayment:
        return 'fastPayment';
    }
  }
}

enum PaymentMethodType {
  masterCard,
  visa,
  paypal,
  americanExpress,
  chinnaUnion,
  dinnerClub,
  discover,
  jcb,
  maestro,
  dankort,
}

extension PaymentMethodTypeExtension on PaymentMethodType {
  String get rawValue {
    switch (this) {
      case PaymentMethodType.masterCard:
        return "ECA";
      case PaymentMethodType.visa:
        return "VIS";
      case PaymentMethodType.paypal:
        return "PAP";
      case PaymentMethodType.americanExpress:
        return "AMX";
      case PaymentMethodType.chinnaUnion:
        return "CUP";
      case PaymentMethodType.dinnerClub:
        return "DIN";
      case PaymentMethodType.discover:
        return "DIS";
      case PaymentMethodType.jcb:
        return "JCB";
      case PaymentMethodType.maestro:
        return "MAU";
      case PaymentMethodType.dankort:
        return "DNK";
    }
  }
}