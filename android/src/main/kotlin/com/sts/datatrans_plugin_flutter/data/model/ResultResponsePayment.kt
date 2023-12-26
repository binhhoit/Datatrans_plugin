package com.sts.datatrans_plugin_flutter.data.model

import com.google.gson.Gson
import com.google.gson.annotations.SerializedName

data class ResultResponsePayment(
    @SerializedName("success")
    val success: Boolean,
    @SerializedName("error")
    val error: String? = null,
    @SerializedName("data")
    val data: Any? = null,
) {
    fun toJson(): String {
        return Gson().toJson(this)
    }
}
