package com.sts.datatrans_plugin_flutter.data.model

import com.google.gson.annotations.SerializedName

data class DatatransRequest(@SerializedName("currency") val currency: String,
                            @SerializedName("amount") val amount: String,
                            @SerializedName("autoSettle") val autoSettle: Boolean = false,
                            @SerializedName("paymentMethods") val paymentMethods: List<String>) {
    companion object {
        const val SUCCESS_URL =
            "https://pay.sandbox.datatrans.com/upp/merchant/successPage.jsp"
        const val CANCEL_URL =
            "https://pay.sandbox.datatrans.com/upp/merchant/cancelPage.jsp"
        const val ERROR_URL =
            "https://pay.sandbox.datatrans.com/upp/merchant/errorPage.jsp"
    }
    @SerializedName("saveAlias")
    var isSaveAlias: Boolean? = false
        set(value) {
            option = option.copy(true, value ?: false)
            field = null
        }
    data class Option(
        @SerializedName("returnMobileToken") val returnMobileToken: Boolean = true,
        @SerializedName("createAlias") val saveAlias: Boolean = false,
    )
    data class Redirect(
        @SerializedName("successUrl") val successUrl: String = SUCCESS_URL,
        @SerializedName("cancelUrl") val cancelUrl: String = CANCEL_URL,
        @SerializedName("errorUrl") val errorUrl: String = ERROR_URL,
    )

    @SerializedName("option")
    var option = Option()
    @SerializedName("redirect")
    val redirect = Redirect()
    @SerializedName("refno") val refno: String = System.currentTimeMillis().toString()
}