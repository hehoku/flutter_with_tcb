# 腾讯云 云开发 Flutter Demo
- [x] 云函数 获取标准时间
- [ ] 数据库使用 curd 数据库
- [ ] 用户管理 用户是否在线
- [ ] 静态资源 获取图片

## 初始化
在 `lib/resource/tcb_api_provider.dart` 文件中，获取时间。

其引用的 `lib/common/constants.dart` 如下:

``` dart
const String ENV_ID = 'test-xxxxxx';
const String APP_KEY = 'xxxx';
const String VERSION = '1';
```

## 调用云函数，获取云函数生成的时间
对应的云函数：
``` js
async function getTime () {
  const ts = Date.now()

  const dateOb = new Date(ts)
  const date = dateOb.getDate()
  const month = dateOb.getMonth() + 1
  const year = dateOb.getFullYear()

  // prints date & time in YYYY-MM-DD format
  return year + '-' + month + '-' + date
}

module.exports = getTime
```
