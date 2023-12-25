package com.sts.datatrans_plugin_flutter.data.repository

import com.sts.datatrans_plugin_flutter.data.model.DatatransRequest
import com.sts.datatrans_plugin_flutter.data.network.config.NetworkModule
import com.sts.datatrans_plugin_flutter.data.network.remote.DatatransApi

class DatatransRepository {
    private val datatransApi: DatatransApi =
        NetworkModule.getInstance().create(DatatransApi::class.java)

    suspend fun getToken(auth: String, datatransRequest: DatatransRequest) =
        datatransApi.getTokenTransaction(auth, datatransRequest)

}