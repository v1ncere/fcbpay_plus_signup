import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:js_interop_utils/js_interop_utils.dart';
import 'package:web/web.dart' as web;

String? getBridgeTokenFromUrl() {
  try {
    final url = web.window.location.href;
    final uri = Uri.parse(url);
    return uri.queryParameters['bridgeToken'];
  } catch (_) {
    return null;
  }
}

/// Converts JS interop or custom Dart Web objects into JSON-safe maps
dynamic _toEncodable(dynamic value) {
  if (value == null) return null;
  if (value is String || value is num || value is bool) return value;
  if (value is Map) {
    return value.map((k, v) => MapEntry(k.toString(), _toEncodable(v)));
  }
  if (value is Iterable) {
    return value.map(_toEncodable).toList();
  }
  // Handle JS interop objects
  if (value.isJSObject) {
    final dartValue = value.dartify();
    return _toEncodable(dartValue);
  }
  // Fallback: stringify the object
  return value.toString();
}

/// Sends a payload to host, automatically includes bridgeToken if available.
void sendToHost(Map<String, dynamic> payload) {
  final token = getBridgeTokenFromUrl();
  if (token != null && token.isNotEmpty) payload['bridgeToken'] = token;
  final jsonString = jsonEncode(_toEncodable(payload));

  try {
    final jsBridge = web.window.getProperty('FlutterBridge'.toJS) as JSObject?;
    final postMsg = jsBridge?.getProperty('postMessage'.toJS) as JSFunction?;
    if (postMsg != null) {
      postMsg.callAsFunction(jsBridge, jsonString.toJS);
      return;
    }

    // Fallback to sendToApp
    final jsFn = web.window.getProperty('sendToApp'.toJS) as JSFunction?;
    if (jsFn != null) {
      jsFn.callAsFunction(web.window, jsonString.toJS);
      return;
    }

    throw Exception('No valid bridge found.');
  } catch (e) {
    web.console.error('sendToHost failed: $e'.toJS);
  }
}

/// Register host listener
void registerHostListener(void Function(Map<String, dynamic>) callback) {
  final jsCallback = (JSAny? jsArg) {
    try {
      final value = jsArg?.dartify();
      final decoded = (value is String) ? jsonDecode(value) : value; 
      if (decoded is Map<String, dynamic>) {
        callback(decoded);
      } else {
        callback({'error': 'Invalid payload structure', 'raw': decoded});
      }
    } catch (e) {
      callback({'error': 'Failed to decode host payload', 'details': e.toString()});
    }
  }.toJS;
  
  // Host will call this when sending data to web.
  web.window.setProperty('onSignupSaved'.toJS, jsCallback);
}