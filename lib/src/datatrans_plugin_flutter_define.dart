enum DatatransMethodIdentity {
  initializeTransaction
}

extension DatatransMethodIdentityExtend on DatatransMethodIdentity {
  String get methodName {
    switch (this) {
      case DatatransMethodIdentity.initializeTransaction:
        return 'initializeTransaction';
    }
  }
}