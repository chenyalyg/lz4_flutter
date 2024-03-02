# 安装

```javascript
lz4_flutter:
  git:
    url: https://github.com/chenyalyg/lz4_flutter.git
    ref: master
```

## 说明

该项目提供 Android,IOS,Windows 下块模式的压缩，解压


## 例子
```javascript
  var dst=await Lz4Flutter.lz4_encode(Uint8List.fromList([1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9]));
  var src=await Lz4Flutter.lz4_decode(dst!,36);
```
