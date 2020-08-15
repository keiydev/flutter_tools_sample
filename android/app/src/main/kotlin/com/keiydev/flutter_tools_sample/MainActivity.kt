package com.keiydev.flutter_tools_sample

import android.content.Intent
import android.graphics.Point
import android.os.Bundle
import android.view.Display
import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

import com.keiydev.flutter_tools_sample.viewplugin.NLayoutPlugin
import com.keiydev.flutter_tools_sample.viewplugin.NMethodTextViewPlugin
import com.keiydev.flutter_tools_sample.viewplugin.NBasicTextViewPlugin
import com.keiydev.flutter_tools_sample.viewplugin.NEventTextViewPlugin
import com.keiydev.flutter_tools_sample.viewplugin.NMethodListViewPlugin

class MainActivity: FlutterActivity() {
  companion object {
    // main.dartでMethodChannelのコンストラクタで指定した文字列です
    private const val CHANNEL = "com.keiydev.flutter_tools_sample/method"
    // main.dartでinvokeMethodの第一引数に指定したmethodの文字列です
    private const val METHOD_TEST = "launchNativeScreen"
  }



  private fun launchAndroidScreen(parameters: String) {
    val intent = Intent()
    intent.action = android.provider.Settings.ACTION_SETTINGS
    //intent.action = Intent.ACTION_MAIN
    //intent.setClassName(getPackageName(), ".LinearLayoutActivity")
    //intent.setClass(this, LinearLayoutActivity::class.java)
    startActivity(intent)
  }

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine)
    flutterEngine.plugins.add(NLayoutPlugin())
    flutterEngine.plugins.add(NMethodTextViewPlugin())
    flutterEngine.plugins.add(NBasicTextViewPlugin())
    flutterEngine.plugins.add(NEventTextViewPlugin())
    flutterEngine.plugins.add(NMethodListViewPlugin())
    //NLayoutFactory.registerWith(this)
    //NMethodTextViewFactory.registerWith(this)
    //NBasicTextViewFactory.registerWith(this)
    //NEventTextViewFactory.registerWith(this)
    //NMethodListViewFactory.registerWith(this)

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
    .setMethodCallHandler { methodCall: MethodCall, result: MethodChannel.Result ->
      when(methodCall.method) {
        METHOD_TEST -> {
          // invokeMethodの第二引数で指定したパラメータを取得できます
          val parameters = methodCall.arguments<String>()
          launchAndroidScreen(parameters)
        }
        "getDisplayHeight" -> {
          val display : Display = windowManager.defaultDisplay
          val size : Point = Point()
          display.getRealSize(size)
          val width = size.x
          val height = size.y
          result.success(height)
        }
        "getDisplayWidth" -> {
          val display : Display = windowManager.defaultDisplay
          val size : Point = Point()
          display.getRealSize(size)
          val width = size.x
          val height = size.y
          result.success(width)
        }
        else -> {
          result.notImplemented()
        }
      }
    }
  }
}
