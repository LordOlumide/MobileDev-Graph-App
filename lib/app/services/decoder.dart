import 'dart:convert';

getDecodedFile() {
  final file = jsonDecode('assets/jsons/Forged Widows Data.json');
  print('File is a ${file.runtimeType}');
  print('File contents:');
  print(file);

  return file;
}
