package com.keiydev.flutter_tools_sample.viewplugin;

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

class NMethodTextViewPlugin : FlutterPlugin {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding.platformViewRegistry
                .registerViewFactory(
                        NMethodTextViewFactory.VIEW_TYPE_ID,
                        NMethodTextViewFactory(flutterPluginBinding.binaryMessenger)
                )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}