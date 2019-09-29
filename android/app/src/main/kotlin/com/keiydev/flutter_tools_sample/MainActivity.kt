package com.keiydev.flutter_tools_sample

import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  companion object {
    // main.dartでMethodChannelのコンストラクタで指定した文字列です
    private const val CHANNEL = "com.keiydev.flutter_tools_sample/method"
    // main.dartでinvokeMethodの第一引数に指定したmethodの文字列です
    private const val METHOD_TEST = "launchNativeScreen"
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    // MethodChannelからのメッセージを受け取ります
    // （flutterViewはFlutterActivityのプロパティ、CHANNELはcompanion objectで定義しています）
    MethodChannel(this.flutterView, CHANNEL)
            .setMethodCallHandler { methodCall: MethodCall, result: MethodChannel.Result ->
              if (methodCall.method == METHOD_TEST) {
                // invokeMethodの第二引数で指定したパラメータを取得できます
                val parameters = methodCall.arguments<String>()
                launchAndroidScreen(parameters)
              }
            }
  }

  private fun launchAndroidScreen(parameters: String) {
    val intent = Intent()
    intent.action = android.provider.Settings.ACTION_SETTINGS
    startActivity(intent)
  }
}
