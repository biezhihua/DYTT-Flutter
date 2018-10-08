package com.bzh.dytt;

import android.os.Bundle;

import com.bzh.dytt.key.KeyUtils;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        KeyUtils.init(this);
        new MethodChannel(getFlutterView(), "com.bzh.dytt/key_utils").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                if (methodCall.method.equals("getHeaderKey")) {
                    try {
                        Long currentTime = ((Long) methodCall.arguments);
                        String headerKey = KeyUtils.getHeaderKey(currentTime);
                        result.success(headerKey);
                    } catch (Exception e) {
                        result.error(e.getClass().getCanonicalName(), e.getMessage(), null);
                    }
                } else {
                    result.notImplemented();
                }
            }
        });
    }
}
