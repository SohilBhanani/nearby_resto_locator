
import 'package:flutter/material.dart';

class TimePicker {
  getPicker(BuildContext context, String helpText, String confirmText) async {
    final TimeOfDay newTime = await showTimePicker(
initialEntryMode: TimePickerEntryMode.input,
        helpText: helpText,
        confirmText: confirmText,
        context: context,
        initialTime: TimeOfDay.now());

    return newTime;
  }
}
