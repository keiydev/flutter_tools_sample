package com.keiydev.flutter_tools_sample.viewplugin;

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class NMethodListViewFactory extends PlatformViewFactory {
    public static final String PLUGIN_KEY = "NMethodListView";
    public static final String VIEW_TYPE_ID = "com.ace.ace_demo01/method_list_view";
    private final BinaryMessenger messenger;

    public NMethodListViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        Map<String, Object> params = (Map<String, Object>) o;
        return new NMethodListView(context, messenger, i, params);
    }
}
