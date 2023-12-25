package com.sts.datatrans_plugin_flutter.data.network.config

import android.net.sip.SipErrorCode.TIME_OUT
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

object NetworkModule {

    private const val BASE_URL = "https://api.sandbox.datatrans.com"

    private fun getHttpLoggingInterceptor(): HttpLoggingInterceptor {
        val interceptor = HttpLoggingInterceptor()
        interceptor.level = HttpLoggingInterceptor.Level.BODY
        return interceptor
    }


    private fun okhttp(): OkHttpClient {
        return OkHttpClient.Builder().apply {
            addInterceptor(getHttpLoggingInterceptor())
            retryOnConnectionFailure(true)
            connectTimeout(30000, TimeUnit.MILLISECONDS)
            readTimeout(30000, TimeUnit.MILLISECONDS)
            writeTimeout(30000, TimeUnit.MILLISECONDS)
        }
            .build()
    }

    fun getInstance(): Retrofit {
        return Retrofit.Builder().baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .client(okhttp())
            .build()
    }
}