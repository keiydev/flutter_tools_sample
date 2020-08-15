package com.keiydev.flutter_tools_sample.viewplugin;

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class NEventTextViewFactory extends PlatformViewFactory {
    public static final String PLUGIN_KEY = "NEventTextView";
    public static final String VIEW_TYPE_ID = "com.keiydev.flutter_tools_sample/event_text_view";
    private final BinaryMessenger messenger;

    public NEventTextViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        Map<String, Object> params = (Map<String, Object>) o;
        return new NEventTextView(context, messenger, i, params);
    }
}
