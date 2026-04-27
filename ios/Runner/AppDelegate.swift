import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Replace YOUR_GOOGLE_MAPS_API_KEY with your actual key from console.cloud.google.com
    GMSServices.provideAPIKey("AIzaSyCnoKVkIYDC8OkqDUS5SW7u5HZcmTpbZ5g")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
