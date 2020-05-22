// import 'package:hash/hash.dart';

/// hex encode
String encodeHEX(List<int> bytes) {
  var str = '';
  for (var i = 0; i < bytes.length; i++) {
    var s = bytes[i].toRadixString(16);
    str += s.padLeft(2 - s.length, '0');
  }
  return str;
}

/// hex decode
List<int> decodeHEX(String hex) {
  var bytes = <int>[];
  var len = hex.length ~/ 2;
  for (var i = 0; i < len; i++) {
    bytes.add(int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16));
  }
  return bytes;
}

// void main() {
//   var hash = decodeHEX(
//       '60bf6c46a8f6d9a02bb5a0f1f8691eb0d7d0cf649424f4d385bdf31fc261b4be');


//   var nombre = encodeHEX([157, 161, 39, 157, 129, 83, 38, 177, 20, 176, 28, 102, 71, 59, 161, 99]);

//   ///MD5
//   var md5 = MD5();
//   var md2= MD5();
//   print(md5.update(hash).digest());
//   print(nombre);
//   /// => [157, 161, 39, 157, 129, 83, 38, 177, 20, 176, 28, 102, 71, 59, 161, 99]
//   print(md5.outSize);

//   /// => 16

// }