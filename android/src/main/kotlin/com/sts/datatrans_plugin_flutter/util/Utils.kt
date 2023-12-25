package com.sts.datatrans_plugin_flutter.util

import android.os.Build
import java.util.Base64

fun String.encode(): String {
    val data = this.toByteArray(charset("UTF-8"))
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        Base64.getEncoder().encodeToString(data)
    } else {
        TODO("VERSION.SDK_INT < O")
    }
}