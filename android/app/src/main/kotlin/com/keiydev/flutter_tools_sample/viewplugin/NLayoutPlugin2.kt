package com.keiydev.flutter_tools_sample.viewplugin;

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

class NLayoutPlugin2 : FlutterPlugin {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding.platformViewRegistry
                .registerViewFactory(
                        NLayoutFactory2.VIEW_TYPE_ID,
                        NLayoutFactory2(flutterPluginBinding.binaryMessenger)
                )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}