## ShareKit
封装第三方分享功能，提供统一调用接口
  
[![Build Status](https://travis-ci.org/JerryChu/ShareKit.svg?branch=master)](https://travis-ci.org/JerryChu/ShareKit)

### 特性
- 接口统一，无需单独适配各个分享SDK
- 面向协议，简单易用
- 实现业务逻辑与分享模块代码隔离

### 分享渠道
- 微信
    - 微信好友
    - 微信朋友圈
    - 微信收藏
- QQ
    - QQ好友
    - QQ空间

### 分享形式
- 文本
- 图片
- 页面（音频、视频、微信小程序等）

### 接入流程
- 按照官方提供的接入指引接入各个分享SDK [微信](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN)  [QQ](http://wiki.open.qq.com/index.php?title=iOS_API%E8%B0%83%E7%94%A8%E8%AF%B4%E6%98%8E&oldid=46716)
- 将ShareKit文件夹添加到工程中
- 使用ShareKit提供的接口完成分享功能

### 注意事项
- 微信（1.8.3版本）
    - 文本分享文本长度限制为`10KB`
    - 图片分享图片大小限制为`10MB`
    - 分享内容标题长度限制为`512B`
    - 分享内容描述长度限制为`1KB`
    - 分享缩略图数据大小限制为`32KB`
    - 分享链接URL长度限制为`10KB`
- QQ（3.3.3版本）
    - 文本分享文本长度限制为`1536B`
    - 图片分享图片大小限制为`5MB`
    - 分享内容标题长度限制为`128B`
    - 分享内容描述长度限制为`512B`
    - 分享缩略图数据大小限制为`1MB`
    - 分享链接URL长度限制为`512B`

在Demo中测试QQ分享时，需要将appID和bundleID替换为真实可用的id。
在Demo中测试微信分享时，可以直接使用官方Demo中提供的bundleID (_com.tencent.xin.SDKSample_)。
