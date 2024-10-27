//
//import android.app.PictureInPictureParams
//import android.content.Context
//import android.content.Intent
//import android.os.Build
//import android.util.Log
//import android.util.Rational
//import androidx.annotation.NonNull
//import io.flutter.embedding.android.FlutterFragmentActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//
////int result = 0;
//class MainActivity : FlutterFragmentActivity() {
//
//    var pip = 0;
//
//    private val channel = "flutter.app/awake"
//    private val locationChannel = "location"
//
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(
//                flutterEngine.dartExecutor.binaryMessenger,
//                channel
//        ).setMethodCallHandler { call, result ->
//            // This method is invoked on the main thread.
//            // TODO
//            if (call.method == "keepon") {
//                getWindow().addFlags(android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
//            }
//            if (call.method == "keepoff") {
//                getWindow().clearFlags(android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
//            }
//            if (call.method == "awakeapp") {
//                awakeapp()
//            }
//            if (call.method == "pipmode") {
//                pipmode()
//            }
//            if (call.method == "login") {
//                pip = 1;
//            }
//            if (call.method == "logout") {
//                pip = 0;
//            }
//
//        }
//        MethodChannel(
//                flutterEngine.dartExecutor.binaryMessenger,
//                locationChannel
//        ).setMethodCallHandler { call, result ->
//            if(call.method == "instantRide"){
//                val sharedPref = this?.getPreferences(Context.MODE_PRIVATE)
//                val location = sharedPref?.getString("location",null);
//                sharedPref?.edit()?.remove("location")?.commit()
//                val link = extractUrls(location.toString());
//                if(link.isNotEmpty()){
//                    result.success(link[0])
//                }
//                else{
//                    result.success(null)
//                }
//
//            }
//
//        }
//        when (intent?.action) {
//            Intent.ACTION_SEND -> {
//                if ("text/plain" == intent.type) {
//                    handleSendText(intent) // Handle text being sent
//                }
//            }
//            else -> {
//                // Handle other intents, such as being started from the home screen
//            }
//        }
//    }
//    private fun extractUrls(input: String): List<String> {
//        val regex = Regex("""\b(?:https?|ftp):\/\/[^\s]+""")
//        val matchResults = regex.findAll(input)
//        return matchResults.map { it.value }.toList()
//    }
//
//    private fun handleSendText(intent: Intent) {
//        intent.getStringExtra(Intent.EXTRA_TEXT)?.let {
//            Log.d("The val is ",it);
//            val sharedPref = this?.getPreferences(Context.MODE_PRIVATE) ?: return
//            with (sharedPref.edit()) {
//                putString("location", it)
//                apply()
//            }
//
//        }
//    }
//    override fun onUserLeaveHint() {
//        if (pip == 1) {
//            pipmode()
//        }
//    }
//
//    private fun awakeapp() {
//        val bringToForegroundIntent = Intent(this, MainActivity::class.java);
//        startActivity(bringToForegroundIntent);
//    }
//
//
//    private fun pipmode() {
//        val rational = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
//            Rational(
//                    50,
//                    75
//            )
//        } else {
//            TODO("VERSION.SDK_INT < LOLLIPOP")
//        }
//
//
//        val params = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            PictureInPictureParams.Builder()
//                    .setAspectRatio(rational)
//                    .build()
//        } else {
//            TODO("VERSION.SDK_INT < O")
//        }
//
//        enterPictureInPictureMode(params)
//    }
//
//}
