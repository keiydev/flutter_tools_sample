package com.keiydev.flutter_tools_sample.viewplugin;

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class NLayoutFactory extends PlatformViewFactory {
    private static final String PLUGIN_KEY = "NLayout";
    private static final String VIEW_TYPE_ID = "com.ace.ace_demo01/method_layout";
    private final BinaryMessenger messenger;

    public NLayoutFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        Map<String, Object> params = (Map<String, Object>) o;
        // create view
        return new NLayout(context, messenger, i, params);
    }

    public static void registerWith(PluginRegistry registry) {
        if (registry.hasPlugin(PLUGIN_KEY)) return;
        PluginRegistry.Registrar registrar = registry.registrarFor(PLUGIN_KEY);
        // register factory
        registrar.platformViewRegistry().registerViewFactory(VIEW_TYPE_ID, new NLayoutFactory(registrar.messenger()));
    }
}
