//
//  Profile.swift
//  UINaviVC
//
//  Created by iKame Elite Fresher 2025 on 6/26/25.
//


struct Profile: Equatable {
    var firstName: String
    var lastName: String
    var bmi: Double
    var weight: Int
    var height: Int
    var gender: String
    
    //chỉ số weight height nên để double/int hay string?
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    init(firstName: String, lastName: String, bmi: Double, weight: Int, height: Int, gender: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.bmi = bmi
        self.weight = weight
        self.height = height
        self.gender = gender
    }
}
