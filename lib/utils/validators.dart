import 'package:grid_tracker/utils/utils.dart';

String? validateNull(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field is empty';
  }
  return null;
}

String? validateIp(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field is empty';
  }
  final RegExp ipV4Regex = RegExp(r'^([0-9]{1,3}\.){3}[0-9]{1,3}$');
  final RegExp ipV6Regex = RegExp(r'^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
  if (ipV4Regex.hasMatch(value) || ipV6Regex.hasMatch(value)) {
    return null;
  }
  return 'Wrong IP or host format';
}

String? validatePort(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field is empty';
  }
  if (int.tryParse(value) == null || int.tryParse(value)! < 0) {
    return 'Wrong port format';
  }
  return null;
}

String? validateCallsign(String? value) {
  if (value == null) {
    return 'Field is null';
  }
  if (value.isEmpty) {
    return null;
  }
  if (!isCallSign(value)) {
    return 'Wrong field format';
  }
  return null;
}

String? validateQth(String? value) {
  if (value == null) {
    return 'Field is null';
  }
  if (value.isEmpty) {
    return null;
  }
  if (!isQTH(value)) {
    return 'Wrong field format';
  }
  return null;
}
