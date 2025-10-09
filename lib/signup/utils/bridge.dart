import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
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

/// Sends a payload to host, automatically includes bridgeToken if available.
void sendToHost(Map<String, dynamic> payload) {
  final token = getBridgeTokenFromUrl();
  if (token != null) {
    payload['bridgeToken'] = token;
  }

  final jsonString = jsonEncode(payload);
  // Try direct global JS function
  final jsFn = web.window.getProperty('sendToApp'.toJS) as JSFunction?;
  if (jsFn != null) {
    jsFn.callAsFunction(web.window, jsonString.jsify());
    return;
  }

  // Fallback (webview FlutterBridge)
  final dynamicWindow = web.window as dynamic;
  try {
    if (dynamicWindow.sendToApp != null) {
      // Direct call if available
      dynamicWindow.sendToApp(jsonString);
      return;
    }
  } catch (_) {}

  web.console.log('sendToHost: bridge not found. payload:$jsonString'.toJS);
}

/// Register host listener
void registerHostListener(void Function(Map<String, dynamic>) callback) {
  final jsCallback = (JSAny? jsArg) {
    try {
      final value = jsArg?.dartify();
      if (value is String) {
        callback(jsonDecode(value) as Map<String, dynamic>);
      } else if (value is Map) {
        callback(Map<String, dynamic>.from(value));
      } else { 
        callback({'raw': value});
      }
    } catch (e) {
      callback({'error': 'invalid_host_payload', 'raw': jsArg});
    }
  }.toJS;
  
  web.window.setProperty('onSignupSaved'.toJS, jsCallback);
}