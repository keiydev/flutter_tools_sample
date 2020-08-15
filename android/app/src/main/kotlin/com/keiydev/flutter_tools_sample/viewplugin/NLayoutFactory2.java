package com.keiydev.flutter_tools_sample.viewplugin;

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class NLayoutFactory2 extends PlatformViewFactory {
    public static final String PLUGIN_KEY = "NLayout";
    public static final String VIEW_TYPE_ID = "com.ace.ace_demo01/method_layout2";
    private final BinaryMessenger messenger;

    public NLayoutFactory2(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        Map<String, Object> params = (Map<String, Object>) o;
        return new NLayout(context, messenger, i, params);
    }
}
