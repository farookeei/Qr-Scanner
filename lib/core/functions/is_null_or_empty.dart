bool isNullOREmpty(dynamic data) {
  if (data == null) return true;

  if (data.isEmpty) return true;

  return false;
}
