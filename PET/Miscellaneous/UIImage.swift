//
//  UIImage.swift
//  PPal
//
//  Created by rclui on 11/11/17.
//  Copyright © 2017 CMPT275. All rights reserved.
//

import Foundation
import UIKit

// UIImage extenstion for image to string conversion
public extension UIImage {
    
    /// Converts the UIImage into a Base64 String.
    var toBase64: String {
        get {
            let imageData: NSData = UIImagePNGRepresentation(self)! as NSData
            return imageData.base64EncodedString(options: [])
        }
    }
    
}
