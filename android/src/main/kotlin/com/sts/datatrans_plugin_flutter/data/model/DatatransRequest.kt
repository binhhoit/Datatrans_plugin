package com.sts.datatrans_plugin_flutter.data.model

import com.google.gson.annotations.SerializedName

data class DatatransRequest(@SerializedName("currency") val currency: String,
                            @SerializedName("amount") val amount: String,
                            @SerializedName("paymentMethods") val paymentMethods: List<String>) {
    companion object {
        const val SUCCESS_URL =
            "https://pay.sandbox.datatrans.com/upp/merchant/successPage.jsp"
        const val CANCEL_URL =
            "https://pay.sandbox.datatrans.com/upp/merchant/cancelPage.jsp"
        const val ERROR_URL =
            "https://pay.sandbox.datatrans.com/upp/merchant/errorPage.jsp"
    }

    data class Option(@SerializedName("returnMobileToken") val returnMobileToken: Boolean = true)
    data class Redirect(
        @SerializedName("successUrl") val successUrl: String = SUCCESS_URL,
        @SerializedName("cancelUrl") val cancelUrl: String = CANCEL_URL,
        @SerializedName("errorUrl") val errorUrl: String = ERROR_URL,
    )

    @SerializedName("option")
    val option = Option()
    @SerializedName("redirect")
    val redirect = Redirect()
    @SerializedName("refno") val refno: String = System.currentTimeMillis().toString()
}