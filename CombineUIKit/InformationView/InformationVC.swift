//
//  InformationVC.swift
//  UINaviVC
//
//  Created by iKame Elite Fresher 2025 on 6/24/25.
//

import UIKit
import Combine

//protocol ResultDelegate: AnyObject {
   // func update(result: String)
//}

class InformationVC: UIViewController, UIGestureRecognizerDelegate {
    private let manager = ProfileManager.shared
    var indexPath: IndexPath?

   // weak var delegate: ResultDelegate?
    
    var fullNameResult: String = ""
    var bmiResult: String = ""
    var weightResult: String = ""
    var heightResult: String = ""
    var genderResult: String = ""
        
    var profile: Profile?
    
    @IBOutlet weak var firstNameCustom: CustomTextField!
    
    @IBOutlet weak var lastNameCustom: CustomTextField!
    
    @IBOutlet weak var weightCustom: CustomTextField!
    
    @IBOutlet weak var heightCustom: CustomTextField!
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    @IBOutlet weak var completeButtonOutlet: UIButton!
    
    @IBAction func updateButton(_ sender: UIButton) {
        
        let heightCmtoM = Double(heightCustom.textFieldCustom.text!) ?? 0.0 / 100
        let BMIValue = Double(weightCustom.textFieldCustom.text!) ?? 0.0 / pow(heightCmtoM, 2)
        
        let newFirstNameResult = firstNameCustom.textFieldCustom.text ?? ""
        let newLastNameResult = lastNameCustom.textFieldCustom.text ?? ""
        let newBmiResult = (BMIValue * 100).rounded() / 100
        let newWeightResult = Int(weightCustom.textFieldCustom.text ?? "") ?? 0
        let newHeightResult = Int(heightCustom.textFieldCustom.text ?? "") ?? 0
        let newGenderResult = genderSegment.titleForSegment(at: genderSegment.selectedSegmentIndex)!
        
//        newProfile = Profile(firstName: newFirstNameResult, lastName: newLastNameResult, bmi: newBmiResult, weight: newWeightResult, height: newHeightResult, gender: newGenderResult)
//        
//        onChangeResult?(newProfile!)
         
        let profile = Profile(firstName: newFirstNameResult, lastName: newLastNameResult, bmi: newBmiResult, weight: newWeightResult, height: newHeightResult, gender: newGenderResult)
        
        if indexPath != nil {
            var current = manager.profiles.value
            current[indexPath!.row] = profile
            manager.profiles.send(current)
        } else {
            var current = manager.profiles.value
            current.append(profile)
            manager.profiles.send(current)
        }
        
        navigationController?.popViewController(animated: true)

    }
        
//    var onChangeResult: ((Profile) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Information"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Left"), style: .plain, target: self, action: #selector(cancel))
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.leftBarButtonItem?.tintColor = .neutral2
        
        firstNameCustom.labelCustom.text = "First name"
        firstNameCustom.textFieldCustom.placeholder = "Enter first name"
        firstNameCustom.textFieldViewCustom.layer.cornerRadius = 16
        firstNameCustom.textFieldViewCustom.layer.borderWidth = 1
        firstNameCustom.textFieldViewCustom.layer.borderColor = UIColor.neutral4.cgColor
        
        lastNameCustom.labelCustom.text = "Last name"
        lastNameCustom.textFieldCustom.placeholder = "Enter last name"
        lastNameCustom.textFieldViewCustom.layer.cornerRadius = 16
        lastNameCustom.textFieldViewCustom.layer.borderWidth = 1
        lastNameCustom.textFieldViewCustom.layer.borderColor = UIColor.neutral4.cgColor
        
        heightCustom.labelCustom.text = "Height"
        heightCustom.textFieldCustom.placeholder = "Cm"
        heightCustom.textFieldViewCustom.layer.cornerRadius = 16
        heightCustom.textFieldViewCustom.layer.borderWidth = 1
        heightCustom.textFieldViewCustom.layer.borderColor = UIColor.neutral4.cgColor
        
        weightCustom.labelCustom.text = "Weight"
        weightCustom.textFieldCustom.placeholder = "Kg"
        weightCustom.textFieldViewCustom.layer.cornerRadius = 16
        weightCustom.textFieldViewCustom.layer.borderWidth = 1
        weightCustom.textFieldViewCustom.layer.borderColor = UIColor.neutral4.cgColor
        
        completeButtonOutlet.layer.cornerRadius = 16
        
        firstNameCustom.textFieldCustom.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        lastNameCustom.textFieldCustom.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        weightCustom.textFieldCustom.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        heightCustom.textFieldCustom.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        completeButtonOutlet.backgroundColor = .neutral3
        completeButtonOutlet.tintColor = .white
        
        
        if let indexPath = indexPath {
               let profile = ProfileManager.shared.profiles.value[indexPath.row]
               firstNameCustom.textFieldCustom.text = profile.firstName
               lastNameCustom.textFieldCustom.text = profile.lastName
               heightCustom.textFieldCustom.text = "\(profile.height)"
               weightCustom.textFieldCustom.text = "\(profile.weight)"
               genderSegment.selectedSegmentIndex = profile.gender == "Male" ? 0 : 1
           }
        
    }
    		
    @objc func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let firstNameFilled = !(firstNameCustom.textFieldCustom.text?.isEmpty ?? true)
        let lastNameFilled = !(lastNameCustom.textFieldCustom.text?.isEmpty ?? true)
        let heightFilled = !(weightCustom.textFieldCustom.text?.isEmpty ?? true)
        let weightFilled = !(weightCustom.textFieldCustom.text?.isEmpty ?? true)
        
        if firstNameFilled && lastNameFilled && heightFilled && weightFilled {
            completeButtonOutlet.isEnabled = true
            completeButtonOutlet.backgroundColor = UIColor.primary1
        } else {
            completeButtonOutlet.isEnabled = false
            completeButtonOutlet.backgroundColor = UIColor.neutral3
        }
      }
    
    
}
