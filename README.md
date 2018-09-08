## ShareKit
封装第三方分享功能，提供统一调用接口

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
- 按照官方提供的接入指引接入各个分享SDK [微信](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN)  [QQ](http://wiki.open.qq.com/wiki/%E5%88%86%E4%BA%AB%E6%B6%88%E6%81%AF%E5%88%B0QQ%EF%BC%88%E5%AE%9A%E5%90%91%E5%88%86%E4%BA%AB%EF%BC%89)
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
- QQ
    - 文本分享文本长度限制为`1536B`
    - 图片分享图片大小限制为`5MB`
    - 分享内容标题长度限制为`128B`
    - 分享内容描述长度限制为`512B`
    - 分享缩略图数据大小限制为`1MB`
    - 分享链接URL长度限制为`512B`

Demo中使用的appID都是官方Demo提供的appID，其中微信分享SDK会对bundleID做校验，官方Demo中的bundleID为 _com.tencent.wc.xin.SDKSample_。
