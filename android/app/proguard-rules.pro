# Keep all TensorFlow Lite classes
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**

# Optional: keep Flutter generated plugin registrant
-keep class io.flutter.plugins.** { *; }

# Optional: prevent Flutter SDK internal classes from being stripped (safety net)
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Optional: avoid stripping entrypoints and lambda targets
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-keepclassmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}
