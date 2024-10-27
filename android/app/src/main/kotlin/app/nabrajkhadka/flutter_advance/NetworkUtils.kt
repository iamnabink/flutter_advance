package app.nabrajkhadka.flutter_advance

import android.annotation.SuppressLint
import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.wifi.WifiInfo
import android.net.wifi.WifiManager
import android.os.Build
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import java.net.HttpURLConnection
import java.net.URL

class NetworkUtils {
    companion object {

        // function to get realtime internet speed
        fun getRealTimeInternetSpeedStream(
                context: Context,
                interval: Long = 1000L,
                testUrl: String = "https://www.google.com"
        ): Flow<Pair<Int, Int>> = flow {
            val connectivityManager =
                    context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

            while (true) {
                val network: Network? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    connectivityManager.activeNetwork
                } else {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                        connectivityManager.allNetworks.firstOrNull { network ->
                            connectivityManager.getNetworkCapabilities(network)?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true
                        }
                    } else {
                        TODO("VERSION.SDK_INT < LOLLIPOP")
                    }
                }

                val networkCapabilities = network?.let { connectivityManager.getNetworkCapabilities(it) }
                if (networkCapabilities != null) {
                    // Measure internet connection by hitting a URL
                    val (responseTime, success) = measureUrlResponseTime(testUrl)
                    if (success) {
                        emit(Pair(responseTime, responseTime)) // using responseTime for both down and up speed as an example
                    } else {
                        emit(Pair(-1, -1))
                    }
                } else {
                    emit(Pair(-1, -1))
                }

                delay(interval)
            }
        }

        // function to measure url response time
        private fun measureUrlResponseTime(urlString: String): Pair<Int, Boolean> {
            return try {
                val url = URL(urlString)
                val startTime = System.currentTimeMillis()
                val urlConnection = url.openConnection() as HttpURLConnection
//            urlConnection.connectTimeout = 5000
//            urlConnection.readTimeout = 5000
                urlConnection.connect()
                val responseCode = urlConnection.responseCode
                val endTime = System.currentTimeMillis()
                urlConnection.disconnect()

                if (responseCode == HttpURLConnection.HTTP_OK) {
                    val responseTime = (endTime - startTime).toInt()
                    Pair(responseTime, true)
                } else {
                    Pair(-1, false)
                }
            } catch (e: Exception) {
                Pair(-1, false)
            }
        }

        // check realtime internet speed
        fun getRealTimeInternetSpeed(context: Context): String {
            val connectivityManager =
                    context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val network = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                connectivityManager.activeNetwork ?: return "No active network"
            } else {
                TODO("VERSION.SDK_INT < M")
            }
            val networkCapabilities =
                    connectivityManager.getNetworkCapabilities(network)
                            ?: return "No network capabilities"

            val downSpeed = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                networkCapabilities.linkDownstreamBandwidthKbps
            } else {
                "Not supported on this device"
            }

            val upSpeed = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                networkCapabilities.linkUpstreamBandwidthKbps
            } else {
                "Not supported on this device"
            }

            return "Download speed: ${downSpeed}Kbps, Upload speed: ${upSpeed}Kbps"
        }

        // get wifi info
        fun getWifiInfo(context: Context): String {
            val wifiManager =
                    context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
            val wifiInfo: WifiInfo = wifiManager.connectionInfo

            val ssid = wifiInfo.ssid
            val bssid = wifiInfo.bssid
            val ipAddress = wifiInfo.ipAddress
            val linkSpeed = wifiInfo.linkSpeed
            val rssi = wifiInfo.rssi
            val networkId = wifiInfo.networkId
//        val frequency = wifiInfo.frequency

return """
        SSID: $ssid
        BSSID: $bssid
        IP Address: ${ipAddress.toIpAddressString()}
        Link Speed: $linkSpeed Mbps
        RSSI: $rssi dBm
        Network ID: $networkId
      """.trimIndent()

        }

        // Helper function to convert IP address from int to string
        @SuppressLint("DefaultLocale")
        private fun Int.toIpAddressString(): String {
            return String.format(
                    "%d.%d.%d.%d",
                    (this and 0xff),
                    (this shr 8 and 0xff),
                    (this shr 16 and 0xff),
                    (this shr 24 and 0xff)
            )
        }

    }
}