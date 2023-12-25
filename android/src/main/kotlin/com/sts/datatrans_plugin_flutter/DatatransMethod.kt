package com.sts.datatrans_plugin_flutter

enum class DatatransMethod(var label:String) {
    INITIALIZE("initialize"),
    SAVE_CARD("saveCardPaymentInfo"),
    PAYMENT("payment"),
    FAST_PAYMENT("fastPayment"),
}