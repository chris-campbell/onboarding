package com.example.onboardingtest;

import android.content.Intent;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.onboarding";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("sendtoforeground")) {
                                startForegroundService();
                            }
                        }
                );
    }

    private void startForegroundService() {
        String input = "hello";
        Intent intent = new Intent(this, ExampleService.class);
        intent.putExtra("input", input);
        startService(intent);
        Toast.makeText(this, "Alarm set.", Toast.LENGTH_SHORT).show();
    }
}