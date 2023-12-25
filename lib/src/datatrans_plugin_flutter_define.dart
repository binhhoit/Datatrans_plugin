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