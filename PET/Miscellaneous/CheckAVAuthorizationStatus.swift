//
//  checkCameraAuthorizationStatus.swift
//  PET
//
//  Created by ANMO on 11/10/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//


import AVFoundation
import Foundation
import UIKit


// Funcion for checking Authorization Status on Camera
func checkCameraAuthorizationStatus() -> Bool {
    
    var result:Bool = false
    let cameraMediaType = AVMediaType.video
    let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
    
    // Check camera status
    switch cameraAuthorizationStatus {
    case .denied: break
    case .authorized: result = true;  break
    case .restricted: break
        
    case .notDetermined:
        // Prompting user for the permission to use the camera.
        AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
            if granted {
                print("Granted access to \(cameraMediaType)")
            } else {
                print("Denied access to \(cameraMediaType)")
            }
        }
    }
    return result
}

