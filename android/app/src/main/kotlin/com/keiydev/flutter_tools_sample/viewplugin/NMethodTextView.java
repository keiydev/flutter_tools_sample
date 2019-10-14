package com.keiydev.flutter_tools_sample.viewplugin;

import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class NMethodTextView implements PlatformView, MethodChannel.MethodCallHandler {
    private TextView mTextView;
    private MethodChannel methodChannel;
    private BinaryMessenger messenger;
    private String mText = "";
    private int mCount = 0;

    NMethodTextView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        this.messenger = messenger;
        TextView mTextView = new TextView(context);
        mTextView.setText("I come from Android Native TextView");
        mTextView.setBackgroundColor(Color.rgb(155, 205, 155));
        mTextView.setGravity(Gravity.CENTER);
        mTextView.setTextSize(16.0f);
        if (params != null && params.containsKey("method_text_str")) {
            mTextView.setText(params.get("method_text_str").toString());
        }
        this.mTextView = mTextView;

        methodChannel = new MethodChannel(messenger, "ace_method_text_view");
        methodChannel.setMethodCallHandler(this);

        mTextView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mTextView.setText(mText + ++mCount);
                methodChannel.invokeMethod("method_click", "Click!");
                Toast.makeText(context, "Method Click NativeToast!", Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall != null && methodCall.method.toString().equals("method_set_text")) {
            mText = methodCall.arguments.toString();
            mTextView.setText(methodCall.arguments.toString());
            result.success("method_set_text_success");
        }
    }

    @Override
    public View getView() { return mTextView; }

    @Override
    public void dispose() { methodChannel.setMethodCallHandler(null); }
}
