//
//  ProfileManager.swift
//  UINaviVC
//
//  Created by iKame Elite Fresher 2025 on 7/16/25.
//

import UIKit
import Combine

class ProfileManager {
    
    static let shared = ProfileManager()
    
    var profiles = CurrentValueSubject<[Profile], Never>(
        []
    )
    
    private init() {}
    
}
