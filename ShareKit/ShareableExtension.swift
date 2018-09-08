//
//  ShareableExtension.swift
//  ShareKit-Demo
//
//  Created by JerryChu on 2018/9/5.
//  Copyright © 2018 JerryChu. All rights reserved.
//

import Foundation

extension String : TextShareable {
    public func textForShare() -> String {
        return self
    }
}

extension NSString : TextShareable {
    public func textForShare() -> String {
        return self as String
    }
}

extension UIImage : ImageShareable {
    public func imageDataForShare() -> Data? {
        return self.pngData()
    }
}
