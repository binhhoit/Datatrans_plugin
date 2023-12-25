package com.sts.datatrans_plugin_flutter.data.model

data class ResultResponsePayment(
    val success: Boolean,
    val error: String? = null,
    val data: Any? = null,
)
