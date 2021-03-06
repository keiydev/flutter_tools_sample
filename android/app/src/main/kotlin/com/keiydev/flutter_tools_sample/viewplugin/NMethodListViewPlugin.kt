package com.keiydev.flutter_tools_sample.viewplugin;

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

class NMethodListViewPlugin : FlutterPlugin {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding.platformViewRegistry
                .registerViewFactory(
                        NMethodListViewFactory.VIEW_TYPE_ID,
                        NMethodListViewFactory(flutterPluginBinding.binaryMessenger)
                )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}