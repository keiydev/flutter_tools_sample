package com.keiydev.flutter_tools_sample.viewplugin;

import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.platform.PlatformView;

public class NEventTextView implements PlatformView, EventChannel.StreamHandler {
    private TextView mTextView;
    private EventChannel eventChannel;
    private BinaryMessenger messenger;

    NEventTextView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        this.messenger = messenger;
        TextView mTextView = new TextView(context);
        mTextView.setTextColor(Color.rgb(250, 105, 25));
        mTextView.setBackgroundColor(Color.rgb(15, 200, 155));
        mTextView.setGravity(Gravity.CENTER);
        mTextView.setPadding(10, 10, 10, 10);
        mTextView.setTextSize(20.0f);
        if (params != null && params.containsKey("event_text_str")) {
            mTextView.setText(params.get("event_text_str").toString());
        }
        this.mTextView = mTextView;

        eventChannel = new EventChannel(messenger, "ace_event_text_view");
        eventChannel.setStreamHandler(this);

        mTextView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(context, "Event Click NativeToast!", Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    public View getView() { return mTextView; }

    @Override
    public void dispose() { eventChannel.setStreamHandler(null); }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        if (o != null) {
            mTextView.setText(o.toString());
            eventSink.success("event_set_text_success");
        }
    }

    @Override
    public void onCancel(Object o) {}
}
