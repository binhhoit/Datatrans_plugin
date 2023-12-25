package com.sts.datatrans_plugin_flutter.data.network.remote

import com.sts.datatrans_plugin_flutter.data.model.DatatransRequest
import com.sts.datatrans_plugin_flutter.data.model.DatatransResponse
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.Header
import retrofit2.http.POST

interface DatatransApi {

    @POST("/v1/transactions")
    suspend fun getTokenTransaction(
        @Header(value = "Authorization") author: String,
        @Body requestData: DatatransRequest,
    ): Response<DatatransResponse>
}