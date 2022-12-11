import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class Encryption {
  static const int _encryptionKeyLength = 32;
  static final iv = IV.fromLength(16);
  static final String _genericKey =  _getSpecificKey();
  static final soundIv = IV.fromUtf8("CUSTOM_KEY_CUSTOM_KEY".substring(0, 16));

  static String encrypt(String toEncrypt) {
    final encrypter = _getEncrypter();
    return encrypter.encrypt(toEncrypt, iv: iv).base64;   
  }

  static String decrypt(String toDecrypt) {
    final decrypter =_getEncrypter();
    return decrypter.decrypt64(toDecrypt, iv: iv);
  }

  static String base64Encrypter(String obsfucate) {
    var bytes = utf8.encode(obsfucate);
    var base64Str = base64.encode(bytes);
    return base64Str;
  }

  static Key getCustomKey(String key) => Key.fromUtf8(key.padRight(32));

  static Encrypter _getEncrypter() {
    final key = Key.fromUtf8(_genericKey);
    return Encrypter(AES(key));
  }

  static _getSpecificKey() {
    // TODO: Get the key from the user's device
    return '';
  }
}