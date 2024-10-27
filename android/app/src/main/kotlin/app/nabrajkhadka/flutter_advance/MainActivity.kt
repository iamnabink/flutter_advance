package app.nabrajkhadka.flutter_advance.flutter_advance

import app.nabrajkhadka.flutter_advance.CustomNotification
import app.nabrajkhadka.flutter_advance.NetworkUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity : FlutterActivity() {

    private var methodChannnel1Name: String = "WIFIINFO"
    private var methodChannnel2Name: String = "CUSTOMNOTIFICATION"
    private var speedStreamChannel: String = "SPEEDSTREAM"
    lateinit var mehtodChannel1: MethodChannel
    lateinit var mehtodChannel2: MethodChannel
    lateinit var eventChannel: EventChannel


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        mehtodChannel1 = MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                methodChannnel1Name
        )
        mehtodChannel2 = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            methodChannnel2Name
        )
        eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, speedStreamChannel)

        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                events.let { eventSink ->
                    GlobalScope.launch {
                        NetworkUtils.getRealTimeInternetSpeedStream(applicationContext).collect { speeds ->
                            val (downSpeed, upSpeed) = speeds
                            withContext(Dispatchers.Main) {
                                eventSink?.success(mapOf("downSpeed" to downSpeed, "upSpeed" to upSpeed))
                            }
                        }
                    }
                }
            }

            override fun onCancel(p0: Any?) {

            }
        })

        mehtodChannel1.setMethodCallHandler { call, result ->
            if (call.method == "getWifiInfo") {
//                text = call.argument("text"); //to take function arguments
                val wifiInfo = NetworkUtils.getWifiInfo(this)
                result.success(wifiInfo)

            }
        }
        mehtodChannel2.setMethodCallHandler { call, result ->
            if (call.method == "showNotification") {
//                text = call.argument("text"); //to take function arguments
                CustomNotification.showCustomNotification(this)
//                result.success(data)

            }
        }
    }


}
