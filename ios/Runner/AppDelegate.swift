import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  /// main.dartでMethodChannelのコンストラクタで指定した文字列です
  private let methodChannelName = "com.keiydev.flutter_tools_sample/method"
  /// main.dartでinvokeMethodの第一引数に指定したmethodの文字列です
  private let methodTest = "launchNativeScreen"

  private var flutterViewController: FlutterViewController {
    return self.window.rootViewController as! FlutterViewController
  }

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // MethodChannelはAndroidと同様、名前とFlutterViewControllerから生成します
    let methdoChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: flutterViewController)
    // MethodChannelからのメッセージを受け取ります
    methdoChannel.setMethodCallHandler { [weak self] methodCall, result in
        if methodChannel.method == methodTest {
            // invokeMethodの第二引数で指定したパラメータを受け取れます
            let parameters = methodCall.arguments as? String
            self?.launchiOSScreen(parameters)
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func launchiOSScreen(_ parameters: String?) {
    if let url = URL(string:"App-Prefs:root=General") {
      if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      } else {
        UIApplication.shared.openURL(url)
      }
    }
  }
}
