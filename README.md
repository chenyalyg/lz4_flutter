# 安装

lz4_flutter: ^0.0.1

## 起步

该项目提供 Android,IOS 下块模式的压缩，解压


Example
```javascript
  var dst=await Lz4Flutter.lz4_encode(Uint8List.fromList([1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9]));
  var src=await Lz4Flutter.lz4_decode(dst!,36);
```
