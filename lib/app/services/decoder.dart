import 'dart:convert';
import 'dart:io';

Future<List<Map<String, dynamic>>> getDecodedFile() async {
  final String fileString =
      await File('Forged Widows Data.json').readAsString();
  final List<Map<String, dynamic>> contents =
      jsonDecode(fileString).cast<Map<String, dynamic>>();

  return contents;
}
