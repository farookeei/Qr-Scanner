import 'package:flutter/material.dart';
import 'package:qr_user/core/env/app_state.dart';
import 'package:qr_user/widgets/snack_notification.dart';

void errorHandler(
    e, GlobalKey<ScaffoldMessengerState> scaffoldKey, BuildContext context) {
  dynamic _errorMsg = StateHandler.errorHandler(e);
  snakBarNotification(
      scaffoldkey: scaffoldKey,
      notification: _errorMsg.toString(),
      context: context);
}
