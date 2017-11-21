//
//  String.swift
//  PPal
//
//  Created by rclui on 10/25/17.
//  Copyright © 2017 CMPT275. All rights reserved.
//

import Foundation
import UIKit

public extension String {

    // Verifies if the email is valid.
    // This property gives:
    // True if email is valid.
    // False if email is invalid.
    var isValidEmail: Bool {
        get {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: self)
        }
    }
    
    // Verifies if the phone number is a valid one.
    // This property gives:
    // - True if the phone number is valid.
    // - false if the phone number is invalid.
    var isValidPhoneNumber: Bool {
        get {
            let validPhoneNumberCharacters = CharacterSet(charactersIn: "-()+1234567890").union(CharacterSet.whitespaces)
            return self.rangeOfCharacter(from: validPhoneNumberCharacters.inverted) == nil
        }
    }
    
    // Assumes a base64 encoded image, and converts this into a UIImage
    // May throw an error if this is not a base64 image.
    var toImage: UIImage {
        get {
            let dataDecoded: NSData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))!
            return UIImage(data: dataDecoded as Data)!
        }
    }
    
}



// EmotionID enum to String converstion UIViewController extension
extension UIViewController {
    
    // Function: Convert from EmotionID enum to String
    // Input: emo: emotionID -> enum of emotion
    // Ouput: String of emotion
    // Pre-req: must be one of the following enum
    func emoTostring(emo: emotionID) -> String{
        if emo == .happy { return "Happy"}
        else if emo == .sad{ return "Sad" }
        else if emo == .angry{ return "Angry" }
        else if emo == .scared{ return "Scared" }
        else if emo == .surprised{ return "Surprised" }
        else if emo == .inlove{ return "Inlove" }
        else if emo == .confused{ return "Confused" }
        else if emo == .shy{ return "Shy" }
        else if emo == .excited{ return "Excited" }
        else if emo == .sick{ return "Sick"}
        else if emo == .confident{ return "Confident"}
        else if emo == .embarrassed{ return "Embarrassed" }
        else{ return "Happy" }
    }
    
    // Function: Convert from String to EmotionID
    // Input: string: String of emotion
    // Ouput: emotionID -> enum of emotion
    // Pre-req: must be one of the following emotion string
    func stringToemo(string: String) -> emotionID{
        if string == "Happy"{ return .happy }
        else if string == "Sad"{ return .sad }
        else if string == "Angry"{ return .angry }
        else if string == "Scared"{ return .scared }
        else if string == "Surprised"{ return .surprised }
        else if string == "Inlove"{ return .inlove }
        else if string == "Confused"{ return .confused }
        else if string == "Shy"{ return .shy }
        else if string == "Excited"{ return .excited }
        else if string == "Sick"{ return .sick }
        else if string == "Confident"{ return .confident }
        else if string == "Embarrassed"{ return .embarrassed }
        else{ return .happy }
    }
}
