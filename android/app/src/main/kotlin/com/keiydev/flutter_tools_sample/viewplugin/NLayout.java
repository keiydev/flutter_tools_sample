package com.keiydev.flutter_tools_sample.viewplugin;

import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.widget.LinearLayout;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class NLayout implements PlatformView {
    private LinearLayout mLinearLayout;
    private BinaryMessenger messenger;
    private int size = 0;

    NLayout(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        this.messenger = messenger;
        LinearLayout mLinearLayout = new LinearLayout(context);
        //mLinearLayout.setBackgroundColor(Color.rgb(100, 200, 100));
        if (params != null && params.containsKey("method_layout_size")) {
            size = Integer.parseInt(params.get("method_layout_size").toString());
        } else {
            size = 900;
        }
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(size, size);
        mLinearLayout.setLayoutParams(lp);
        this.mLinearLayout = mLinearLayout;
    }

    @Override
    public View getView() { return mLinearLayout; }

    @Override
    public void dispose() {}
}

