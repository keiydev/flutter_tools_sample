package com.keiydev.flutter_tools_sample.viewplugin;

import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Map;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StringCodec;
import io.flutter.plugin.platform.PlatformView;

public class NBasicTextView implements PlatformView, BasicMessageChannel.MessageHandler {
    private TextView mTextView;
    private BasicMessageChannel basicMessageChannel;
    private BinaryMessenger messenger;

    NBasicTextView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        this.messenger = messenger;
        TextView mTextView = new TextView(context);
        mTextView.setTextColor(Color.rgb(155, 155, 205));
        mTextView.setBackgroundColor(Color.rgb(155, 105, 155));
        mTextView.setGravity(Gravity.CENTER);
        mTextView.setTextSize(18.0f);
        if (params != null && params.containsKey("basic_text_str")) {
            mTextView.setText(params.get("basic_text_str").toString());
        }
        this.mTextView = mTextView;

        basicMessageChannel = new BasicMessageChannel(messenger, "ace_basic_text_view", StringCodec.INSTANCE);
        basicMessageChannel.setMessageHandler(this);

        mTextView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                basicMessageChannel.send("basic_text_click");
                Toast.makeText(context, "Basic Click NativeToast!", Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    public View getView() { return mTextView; }

    @Override
    public void dispose() { basicMessageChannel.setMessageHandler(null); }

    @Override
    public void onMessage(Object o, BasicMessageChannel.Reply reply) {
        if (o != null){
            mTextView.setText(o.toString());
            basicMessageChannel.send("basic_set_text_success");
        }
    }
}
