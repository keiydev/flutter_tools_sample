package com.keiydev.flutter_tools_sample.viewplugin;

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

class NBasicTextViewPlugin : FlutterPlugin {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding.platformViewRegistry
                .registerViewFactory(
                        NBasicTextViewFactory.VIEW_TYPE_ID,
                        NBasicTextViewFactory(flutterPluginBinding.binaryMessenger)
                )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}