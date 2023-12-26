package com.sts.datatrans_plugin_flutter.data.model

import com.google.gson.annotations.SerializedName

data class SaveCardPayment(
    @SerializedName("alias") val alias: String,
    @SerializedName("cardNumber") val cardNumber: String,
    @SerializedName("cardHolder") val cardHolder: String,
    @SerializedName("expiredDate") val expiredDate: ExpiredDate,
    @SerializedName("paymentMethod") val paymentMethod: String,
)

data class ExpiredDate(
    @SerializedName("month") val month: Int,
    @SerializedName("year") val year: Int,
)