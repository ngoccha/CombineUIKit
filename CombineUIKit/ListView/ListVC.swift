//
//  ListVC.swift
//  UINaviVC
//
//  Created by iKame Elite Fresher 2025 on 6/26/25.
//

import UIKit
import Combine

class ListVC: UIViewController {
    private let manager = ProfileManager.shared
    private var cancel = Set<AnyCancellable>()

    var profile: Profile?
    var profiles: [Profile] = []
        

    @IBOutlet weak var emptyView: UIView!
    
    
    @IBAction func addProfileButton(_ sender: UIButton) {
       addProfile()
    }
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(addProfile))
        
        listTableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        manager.profiles
                   .sink { [weak self] profiles in
                       self?.profiles = profiles
                       self?.listTableView.reloadData()
                       self?.emptyView.isHidden = !profiles.isEmpty
                   }
                   .store(in: &cancel)
    }
    
    
    @objc func addProfile() {
        let infoStoryboard = UIStoryboard(name: "InformationVC", bundle: nil)

        guard let infoVC = infoStoryboard.instantiateViewController(withIdentifier: "InformationVC") as? InformationVC else { return }
        
//        infoVC.onChangeResult = { [weak self] newProfile in
//            guard let self = self else { return }
//            self.profiles.append(newProfile)
//            self.nameListTableView.reloadData()
//            emptyView.isHidden = !profiles.isEmpty
//        }
        
        
        self.navigationController?.pushViewController(infoVC, animated: true)
        
    }
    
}

extension ListVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        
        let profile = profiles[indexPath.row]
        let weightAndHeight = "W: \(profile.weight) kg - H: \(profile.height) cm"
        cell.configCell(name: profile.fullName, weightAndHeight: weightAndHeight)

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVCStoryboard = UIStoryboard(name: "Main", bundle: nil)

        guard let profileVC = profileVCStoryboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        
        let selectedProfile = profiles[indexPath.row]
        profileVC.profile = selectedProfile
        profileVC.indexPath = indexPath
        
//        profileVC.onDeleteProfile = { [weak self] index in
//                guard let self = self else { return }
//                self.profiles.remove(at: index)
//                self.listTableView.reloadData()
//                self.emptyView.isHidden = !self.profiles.isEmpty
//        }

        self.navigationController?.pushViewController(profileVC, animated: true)    }
}

