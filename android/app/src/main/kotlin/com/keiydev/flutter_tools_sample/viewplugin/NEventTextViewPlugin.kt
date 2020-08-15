package com.keiydev.flutter_tools_sample.viewplugin;

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

class NEventTextViewPlugin : FlutterPlugin {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding.platformViewRegistry
                .registerViewFactory(
                        NEventTextViewFactory.VIEW_TYPE_ID,
                        NEventTextViewFactory(flutterPluginBinding.binaryMessenger)
                )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}