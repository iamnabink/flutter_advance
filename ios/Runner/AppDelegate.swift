import UIKit
import Flutter
import NetworkExtension
import CoreLocation
import Foundation
import Network


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let methodChannelName : String = "WIFIINFO"
      let functionName : String = "getWifiInfo"
      let eventChannelName: String = "SPEEDSTREAM"
      let wifiInfoManager = WiFiInfoManager()
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let flutterMethodChannel : FlutterMethodChannel = FlutterMethodChannel(name:methodChannelName,binaryMessenger: controller.binaryMessenger
      )
      let eventChannel = FlutterEventChannel(name:eventChannelName,binaryMessenger:controller.binaryMessenger)
      eventChannel.setStreamHandler(InternetSpeedProvider())
      flutterMethodChannel.setMethodCallHandler({
     [weak self] (call : FlutterMethodCall, result : @escaping FlutterResult) -> Void in
          guard call.method == functionName else{
              result(FlutterMethodNotImplemented)
              return
          }
          // Fetch WiFi info and handle the returned string
                  wifiInfoManager.fetchWiFiInfo { infoString in
                      if let infoString = infoString {
                          result(infoString)
                          // You can now use the infoString as needed
                      } else {
                          print("Failed to fetch WiFi info.")
                          result(FlutterMethodNotImplemented)
                      }
                  }
      })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
