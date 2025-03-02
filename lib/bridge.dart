import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bridge {
  static const MethodChannel _channel = MethodChannel('com.geminiwen.muyu/channel');

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    _channel.setMethodCallHandler(_handleMethod);

    DesktopMultiWindow.setMethodHandler(_handleMultiWindowMethod);
  }

  static Future<dynamic> _handleMultiWindowMethod(MethodCall call, int fromWindowId) async {
    switch (call.method) {
      case 'getValueFromSharedPreference':
        final key = call.arguments['key'] as String;
        final sp = await SharedPreferences.getInstance();
        return sp.get(key);
       case 'setStringToSharedPreference':
        final key = call.arguments['key'] as String;
        final value = call.arguments['value'] as String;
        final sp = await SharedPreferences.getInstance();
        return sp.setString(key, value);
      default:
        throw PlatformException(
          code: 'NotImplemented',
          message: 'Method ${call.method} not implemented',
        );
    }
  }

  static Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'openSettings':
        return _openSettings();
      default:
        throw PlatformException(
          code: 'NotImplemented',
          message: 'Method ${call.method} not implemented',
        );
    }
  }

  static Future<void> _openSettings() async {
    try {
      final window = await DesktopMultiWindow.createWindow(jsonEncode({
        'args1': 'settings-window',
        'args2': '--window-type=settings'
      }));
      
      window
        ..setFrame(const Offset(0, 0) & const Size(314, 175))
        ..center()
        ..resizable(false)
        ..setTitle('Settings')
        ..show();

    } catch (e) {
      throw PlatformException(
        code: 'WindowCreationFailed',
        message: 'Failed to create settings window: $e',
      );
    }
  }
}