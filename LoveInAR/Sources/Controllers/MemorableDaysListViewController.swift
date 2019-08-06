//
//  MemorableDaysListViewController.swift
//  LaunchingMissile
//
//  Created by Venkata Pranathi on 28/07/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import UIKit

class MemorableDaysListViewController: UIViewController {

    var memorableDays = ["ValentinesDay", "RoseDay", "MothersDay", "FathersDay", "KissDay", "NewYear", "Diwali", "Christmas", "ProposeDay", "TeddyDay", "ChocolateDay"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Lovable Days"
    }
}

extension MemorableDaysListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memorableDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memorabledaysTableViewCell", for: indexPath) as? MemorabledaysTableViewCell
        cell?.dayName.text = self.memorableDays[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "uploadVC") as? UploadViewController
        vc?.selectedImageName = self.memorableDays[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
