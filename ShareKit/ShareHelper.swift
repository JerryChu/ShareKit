//
//  ShareHelper.swift
//  ShareKit-Demo
//
//  Created by JerryChu on 2018/9/2.
//  Copyright © 2018 JerryChu. All rights reserved.
//

import Foundation

// 分享渠道
public enum ShareDestination : Int {
    case weChatSession  // 微信聊天
    case weChatTimeline // 微信朋友圈
    case weChatFavorite // 微信收藏
    case qqFriend // QQ好友
    case qZone    // QQ空间
    
    fileprivate var isWeChat: Bool {
        switch self {
        case .weChatSession, .weChatTimeline, .weChatFavorite:
            return true
        default:
            return false
        }
    }
    
    fileprivate var isQQ: Bool {
        switch self {
        case .qqFriend, .qZone:
            return true
        default:
            return false
        }
    }
    
    // 微信分享场景字段
    fileprivate var weChatScene: Int32 {
        var scene = WXSceneSession
        switch self {
        case .weChatSession:
            scene = WXSceneSession
        case .weChatTimeline:
            scene = WXSceneTimeline
        case .weChatFavorite:
            scene = WXSceneFavorite
        default:
            assert(false, "invalid share destination: \(self)")
            scene = WXSceneSession
        }
        return Int32(scene.rawValue)
    }
}

// 链接分享类型
public enum URLShareType {
    case `default`   // 默认样式
    case video       // 视频样式
    case audio       // 音频样式
    case wechatMiniProgram // 小程序样式
}


public class ShareHelper : NSObject {
    
    /// 纯文本分享
    ///
    /// - Parameters:
    ///   - shareable: 分享数据
    ///   - destination: 分享渠道
    /// - Returns: 是否分享成功（仅表示请求调用成功，不代表实际分享结果）
    @discardableResult
    public class func shareText(_ shareable: TextShareable, to destination: ShareDestination) -> Bool {
        if !canShare(to: destination) {
            print("unable to share to \(destination)")
            return false
        }
        
        let text = shareable.textForShare()
        
        if destination.isWeChat {
            let req = SendMessageToWXReq()
            req.bText = true
            req.text = text
            req.scene = destination.weChatScene
            return send(req: req, to: destination)
        } else if destination.isQQ {
            let obj = QQApiTextObject()
            obj.text = text
            let req = SendMessageToQQReq(content: obj)
            return send(req: req!, to: destination)
        }
        return false
    }
    
    /// 纯图片分享
    ///
    /// - Parameters:
    ///   - shareable: 分享数据
    ///   - destination: 分享渠道
    /// - Returns: 是否分享成功（仅表示请求调用成功，不代表实际分享结果）
    @discardableResult
    public class func shareImage(_ shareable: ImageShareable, to destination: ShareDestination) -> Bool {
        if !canShare(to: destination) {
            print("unable to share to \(destination)")
            return false
        }
        
        guard let data = shareable.imageDataForShare() else {
            print("invalid imageData for sharing to \(destination)")
            return false
        }
        let thumbnailData = shareable.thumbnailImageDataForShare()
        
        if destination.isWeChat {
            let obj = WXImageObject()
            obj.imageData = data
            let msg = WXMediaMessage()
            msg.thumbData = thumbnailData
            msg.mediaObject = obj
            let req = SendMessageToWXReq()
            req.bText = false
            req.scene = destination.weChatScene
            req.message = msg
            return send(req: req, to: destination)
        } else if destination.isQQ {
            let obj = QQApiImageObject()
            obj.data = data
            obj.previewImageData = thumbnailData
            let req = SendMessageToQQReq(content: obj)
            return send(req: req!, to: destination)
        }
        return false
    }
    
    /// 页面分享
    /// 音频分享有特殊样式，分享后点击分享card可以直接播放音频，需要设置单独的音频数据url；视频分享与普通页面分享一致，所以暂时不需要设置的视频数据url
    ///
    /// - Parameters:
    ///   - shareable: 分享数据
    ///   - destination: 分享渠道
    /// - Returns: 是否分享成功（仅表示请求调用成功，不代表实际分享结果）
    @discardableResult
    public class func shareURL(_ shareable: URLShareable, to destination: ShareDestination) -> Bool {
        if !canShare(to: destination) {
            print("unable to share to \(destination)")
            return false
        }

        let pageUrl = shareable.pageUrlForShare()
        let title = shareable.titleForShare()
        let description = shareable.descriptionForShare()
        let thumbnailData = shareable.thumbnailImageDataForShare()
        let thumbnailUrl = shareable.thumbnailUrlForShare()
        let shareType = shareable.urlShareType()
        
        if destination.isWeChat {
            let msg = WXMediaMessage()
            msg.title = title
            msg.description = description
            msg.thumbData = thumbnailData

            switch shareType {
            case .video:
                let obj = WXVideoObject()
                obj.videoUrl = pageUrl
                msg.mediaObject = obj
            case .audio:
                guard let dataUrl = shareable.audioUrlForShare() else {
                    print("invalid audio url for sharing to \(destination)")
                    return false
                }
                let obj = WXMusicObject()
                obj.musicUrl = pageUrl
                obj.musicDataUrl = dataUrl
                msg.mediaObject = obj                
            case .wechatMiniProgram:
                guard let path = shareable.wechatMiniProgramPath(), let userName = shareable.wechatMiniProgramUserName() else {
                    print("invalid miniProgram config for sharing to \(destination)")
                    return false
                }
                let obj = WXMiniProgramObject()
                obj.webpageUrl = pageUrl
                obj.userName = userName
                obj.path = path
                obj.withShareTicket = true
                obj.miniProgramType = WXMiniProgramType.release
                msg.mediaObject = obj
            default:
                let obj = WXWebpageObject()
                obj.webpageUrl = pageUrl
                msg.mediaObject = obj
            }
            
            let req = SendMessageToWXReq()
            req.bText = false
            req.message = msg
            req.scene = destination.weChatScene
            return send(req: req, to: destination)
        } else if destination.isQQ {
            var urlObj = QQApiURLObject()
            switch shareType {
            case .video:
                let obj = QQApiVideoObject()
                obj.targetContentType = QQApiURLTargetTypeVideo
                urlObj = obj
            case .audio:
                let obj = QQApiVideoObject()
                obj.targetContentType = QQApiURLTargetTypeAudio
                if let audioUrl = shareable.audioUrlForShare() {
                    obj.flashURL = URL(string: audioUrl)
                }
                urlObj = obj
            case .wechatMiniProgram:
                assert(false)
            default:
                let obj = QQApiNewsObject()
                obj.targetContentType = QQApiURLTargetTypeNews
                urlObj = obj
            }
            urlObj.title = title
            urlObj.description = description
            urlObj.url = URL(string: pageUrl)
            if let data = thumbnailData {
                urlObj.previewImageData = data
            } else if let url = thumbnailUrl {
                urlObj.previewImageURL = URL(string: url)
            }
            let req = SendMessageToQQReq(content: urlObj)
            return send(req: req!, to: destination)
        }
        return false
    }
    
    public class func canShare(to destination: ShareDestination) -> Bool {
        if destination.isWeChat {
            return WXApi.isWXAppInstalled() && WXApi.isWXAppSupport()
        } else if destination.isQQ {
            return QQApiInterface.isSupportShareToQQ()
        }
        return false
    }
    
    private class func send(req: AnyObject, to destination: ShareDestination) -> Bool {
        if destination.isWeChat {
            let success = WXApi.send(req as! SendMessageToWXReq)
            print("sharing to \(destination) success: \(success)")
            return success
        } else if destination.isQQ {
            var code = EQQAPISENDSUCESS
            if destination == .qZone {
                code = QQApiInterface.sendReq(toQZone: req as! SendMessageToQQReq)
            } else {
                code = QQApiInterface.send(req as! SendMessageToQQReq)
            }
            print("sharing to \(destination) finish with code: \(code)")
            return code == EQQAPISENDSUCESS
        }
        return false
    }

}
