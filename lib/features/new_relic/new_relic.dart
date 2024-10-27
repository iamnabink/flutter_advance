import 'package:newrelic_mobile/config.dart';
import 'package:newrelic_mobile/newrelic_mobile.dart';

// ref : https://pub.dev/packages/newrelic_mobile
var appToken = "";

// if (Platform.isAndroid) {
// appToken = "<android app token>";
// } else if (Platform.isIOS) {
// appToken = "<ios app token>";
// }

Config config = Config(
  accessToken: appToken,

//Android Specific
// Optional:Enable or disable collection of event data.
  analyticsEventEnabled: true,

// Optional:Enable or disable reporting network and HTTP request errors to the MobileRequestError event type.
  networkErrorRequestEnabled: true,

// Optional:Enable or disable reporting successful HTTP requests to the MobileRequest event type.
  networkRequestEnabled: true,

// Optional:Enable or disable crash reporting.
  crashReportingEnabled: true,

// Optional:Enable or disable interaction tracing. Trace instrumentation still occurs, but no traces are harvested. This will disable default and custom interactions.
  interactionTracingEnabled: true,

// Optional:Enable or disable capture of HTTP response bodies for HTTP error traces, and MobileRequestError events.
  httpResponseBodyCaptureEnabled: true,

// Optional: Enable or disable agent logging.
  loggingEnabled: true,

//iOS Specific
// Optional:Enable/Disable automatic instrumentation of WebViews
  webViewInstrumentation: true,

//Optional: Enable or Disable Print Statements as Analytics Events
  printStatementAsEventsEnabled: true,

// Optional:Enable/Disable automatic instrumentation of Http Request
  httpInstrumentationEnabled: true,

// Optional : Enable or disable reporting data using different endpoints for US government clients
  fedRampEnabled: false,

// Optional: Enable or disable offline data storage when no internet connection is available.
  offlineStorageEnabled: true,

// iOS Specific
// Optional: Enable or disable background reporting functionality.
  backgroundReportingEnabled: true,

// iOS Specific
// Optional: Enable or disable to use our new, more stable, event system for iOS agent.
  newEventSystemEnabled: true,

// Optional: Enable or disable distributed tracing.
  distributedTracingEnabled: true,
);
