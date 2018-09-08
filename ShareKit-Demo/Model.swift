//
//  Model.swift
//  ShareKit-Demo
//
//  Created by JerryChu on 2018/9/6.
//  Copyright © 2018 JerryChu. All rights reserved.
//

import Foundation

class ImageModel : ImageShareable {
    
    func imageDataForShare() -> Data? {
        let image = UIImage(named: "avatar.png")
        return image?.pngData()
    }
    
    func thumbnailImageDataForShare() -> Data? {
        let image = UIImage(named: "avatar.png")
        return image?.pngData()
    }
    
}

class URLModel : URLShareable {

    func pageUrlForShare() -> String {
        return "http://jerrychu.github.io"
    }
    
    func titleForShare() -> String {
        return "blog"
    }
    
    func descriptionForShare() -> String? {
        return "jerrychu's tech blog"
    }
    
    func thumbnailUrlForShare() -> String? {
        return "https://avatars3.githubusercontent.com/u/4471501?s=400&u=f5fdd194ee4a218d602edea57d729db0ac92cf6e&v=4"
    }
    
    func thumbnailImageDataForShare() -> Data? {
        let image = UIImage(named: "avatar.png")
        return image?.pngData()
    }
    
}

class AudioModel : URLShareable {
    
    func pageUrlForShare() -> String {
        return "http://music.qq.com"
//        return "http://techslides.com/demos/samples/sample.mp3"
    }
    
    func titleForShare() -> String {
        return "sample mp3"
    }
    
    func descriptionForShare() -> String? {
        return nil
    }
    
    func urlShareType() -> URLShareType {
        return .audio
    }
    
    func audioUrlForShare() -> String? {
        return "http://techslides.com/demos/samples/sample.mp3"
    }
    
}

class VideoModel : URLShareable {
    
    func pageUrlForShare() -> String {
        return "http://techslides.com/demos/samples/sample.mp4"
    }
    
    func titleForShare() -> String {
        return "sample mp4"
    }
    
    func descriptionForShare() -> String? {
        return nil
    }
    
    func urlShareType() -> URLShareType {
        return .video
    }
    
}
