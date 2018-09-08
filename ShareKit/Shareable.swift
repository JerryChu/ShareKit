//
//  Shareable.swift
//  ShareKit-Demo
//
//  Created by JerryChu on 2018/9/2.
//  Copyright © 2018 JerryChu. All rights reserved.
//

import Foundation

// MARK: - 文本分享
public protocol TextShareable {

    ///  要分享的文本
    ///
    /// - Returns: 分享文本
    func textForShare() -> String

}

// MARK: - 图片分享
public protocol ImageShareable {

    /// 要分享的图片数据
    ///
    /// - Returns: 图片数据
    func imageDataForShare() -> Data?
 
    /// 要分享的图片对应的缩略图数据
    ///
    /// - Returns: 缩略图数据
    func thumbnailImageDataForShare() -> Data?

}

public extension ImageShareable {
    
    func thumbnailImageDataForShare() -> Data? {
        return nil
    }
    
}

// MARK: - 链接分享
public protocol URLShareable {
    
    /// 页面链接
    ///
    /// - Returns: 页面url
    func pageUrlForShare() -> String
    
    /// 内容标题
    ///
    /// - Returns: 标题
    func titleForShare() -> String
    
    /// 内容简介
    ///
    /// - Returns: 简介
    func descriptionForShare() -> String?

    /// 内容缩略图url
    ///
    /// - Returns: 缩略图url
    func thumbnailUrlForShare() -> String?

    /// 内容缩略图数据
    /// 微信仅支持传递缩略图数据，不支持传递缩略图url
    ///
    /// - Returns: 缩略图数据
    func thumbnailImageDataForShare() -> Data?
    
    /// 链接分享类型
    ///
    /// - Returns: 分享类型
    func urlShareType() -> URLShareType
    
    /// 音频数据url（分享类型为音频时需要提供）
    ///
    /// - Returns: 音频数据url
    func audioUrlForShare() -> String?

    /// 视频数据url（分享类型为视频时需要提供）
    /// 目前视频分享类型和普通分享保持一致，点击进入页面后才可播放，暂时不用获取视频数据url
    ///
    /// - Returns: 音频数据url
//    func videoUrlForShare() -> String?

    /// 微信小程序页面路径（分享类型为小程序分享时需要提供）
    ///
    /// - Returns: 页面路径
    func wechatMiniProgramPath() -> String?
    
    /// 微信小程序userName（分享类型为小程序分享时需要提供）
    ///
    /// - Returns: 小程序userName
    func wechatMiniProgramUserName() -> String?
}

public extension URLShareable {
    
    func descriptionForShare() -> String? {
        return nil
    }
    
    func thumbnailUrlForShare() -> String? {
        return nil
    }
    
    func thumbnailImageDataForShare() -> Data? {
        return nil
    }
    
    func urlShareType() -> URLShareType {
        return .default
    }
    
    func audioUrlForShare() -> String? {
        return nil
    }

//    func videoUrlForShare() -> String? {
//        return nil
//    }

    func wechatMiniProgramPath() -> String? {
        return nil
    }
    
    func wechatMiniProgramUserName() -> String? {
        return nil
    }
    
}
