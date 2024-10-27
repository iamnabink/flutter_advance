//
//  NetworkUtils.swift
//  Runner
//
//  Created by nex on 17/06/2024.
//

import Foundation
import NetworkExtension
import CoreLocation
import Network

// or use : https://github.com/bertrandmartel/speed-test-lib/
// https://stackoverflow.com/questions/12252639/measuring-download-speed-with-java-android
class InternetSpeedProvider: NSObject, FlutterStreamHandler {
    var timer: Timer?
    private var eventSink: FlutterEventSink?

    func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        print("onListen......")
        self.eventSink = eventSink

        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            guard let eventSink = self.eventSink else { return }

            self.getNetworkData { networkData in
                eventSink(networkData)
            }
        })

        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        timer?.invalidate()
        timer = nil
        return nil
    }

   private func getNetworkData(completion: @escaping ([String: Any]) -> Void) {
       var networkData: [String: Any] = [:]
       let monitor = NWPathMonitor()
       let queue = DispatchQueue(label: "NetworkMonitor")

       monitor.pathUpdateHandler = { path in
           if path.status == .satisfied {
               if let interfaceType = path.availableInterfaces.first?.type {
                   switch interfaceType {
                   case .wifi:
                       networkData["networkType"] = "WiFi"
                   case .cellular:
                       networkData["networkType"] = "Cellular"
                   default:
                       networkData["networkType"] = "Unknown"
                   }
               }

               // Measure download speed
               self.measureDownloadSpeed { downloadSpeed in
                   networkData["downSpeed"] = downloadSpeed
                   // Optionally, you can add an upload speed measurement here
                   networkData["upSpeed"] = 0.0 // Placeholder for upload speed
                   completion(networkData)
               }
           } else {
               networkData["networkType"] = "No connection"
               networkData["downSpeed"] = 0.0
               networkData["upSpeed"] = 0.0
               completion(networkData)
           }
           monitor.cancel() // Stop monitoring once data is retrieved
       }

       monitor.start(queue: queue)
   }

   private func measureDownloadSpeed(completion: @escaping (Double) -> Void) {
       guard let url = URL(string: "https://example.com/testfile") else {
           completion(0.0)
           return
       }

       let startTime = Date()
       let task = URLSession.shared.dataTask(with: url) { data, response, error in
           guard let data = data, error == nil else {
               completion(0.0)
               return
           }

           let elapsedTime = Date().timeIntervalSince(startTime)
           let speed = Double(data.count) / elapsedTime / 1024.0 // speed in KB/s
           completion(speed)
       }

       task.resume()
   }
}


class WiFiInfoManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var completion: ((String?) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchWiFiInfo(completion: @escaping (String?) -> Void) {
        self.completion = completion
        NEHotspotNetwork.fetchCurrent { network in
            var result: String?
            if let network = network {
                result = """
                SSID: \(network.ssid)
                BSSID: \(network.bssid)
                Signal Strength: \(network.signalStrength)
                Secure: \(network.isSecure)
                Auto Joined: \(network.didAutoJoin)
                Just Joined: \(network.didJustJoin)
                Chosen Helper: \(network.isChosenHelper)
                """
                print(result ?? "No WiFi information available")
            } else {
                result = "No WiFi network information available"
            }
            completion(result)
        }
    }
    
    // CLLocationManagerDelegate
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse || status == .authorizedAlways {
//            // No need to call fetchWiFiInfo here, as it will be called when the user wants to fetch info.
//        } else {
//            print("Location authorization denied")
//            completion?("Location authorization denied")
//        }
//    }
}
