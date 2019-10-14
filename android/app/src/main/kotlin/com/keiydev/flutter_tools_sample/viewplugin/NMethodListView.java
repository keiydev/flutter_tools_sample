package com.keiydev.flutter_tools_sample.viewplugin;

import android.content.Context;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class NMethodListView implements PlatformView, MethodChannel.MethodCallHandler, ListView.OnItemClickListener, ListView.OnItemLongClickListener {

    private Context context;
    private ListView mListView;
    private MethodChannel methodChannel;
    private List<Map<String, String>> list = new ArrayList<>();
    private SimpleAdapter simpleAdapter = null;
    private int listSize = 0;

    NMethodListView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        this.context = context;
        ListView mListView = new ListView(context);
        if (params != null && params.containsKey("method_list_size")) {
            listSize = Integer.parseInt(params.get("method_list_size").toString());
        }
        if (list != null) { list.clear(); }
        for (int i = 0; i < listSize; i++) {
            Map<String, String> map = new HashMap<>();
            map.put("id", "current item = " + (i + 1));
            list.add(map);
        }
        simpleAdapter = new SimpleAdapter(context, list, android.R.layout.simple_list_item_1, new String[] { "id" }, new int[] { android.R.id.text1 });
        mListView.setAdapter(simpleAdapter);
        mListView.setOnItemClickListener(this);
        mListView.setOnItemLongClickListener(this);
        this.mListView = mListView;

        methodChannel = new MethodChannel(messenger, "ace_method_list_view");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public View getView() { return mListView; }

    @Override
    public void dispose() { methodChannel.setMethodCallHandler(null); }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall != null && methodCall.method.toString().equals("method_set_list")) {
            if (list != null) { list.clear(); }
            for (int i = 0; i < Integer.parseInt(methodCall.arguments.toString()); i++) {
                Map<String, String> map = new HashMap<>();
                map.put("id", "current item = " + (i + 1));
                list.add(map);
            }
            simpleAdapter.notifyDataSetChanged();
            result.success("method_set_list_success");
        }
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        methodChannel.invokeMethod("method_item_click", position);
        Toast.makeText(context, "ListView.onItemClick NativeToast! position -> " + position, Toast.LENGTH_SHORT).show();
    }

    @Override
    public boolean onItemLongClick(AdapterView<?> parent, View view, int position, long id) {
        methodChannel.invokeMethod("method_item_long_click", list.get(position).get("id"));
        Toast.makeText(context, "ListView.onItemLongClick NativeToast! " + list.get(position).get("id"), Toast.LENGTH_SHORT).show();
        return true;
    }
}
