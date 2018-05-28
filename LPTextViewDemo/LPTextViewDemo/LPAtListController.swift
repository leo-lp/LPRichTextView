//
//  LPAtListController.swift
//  LPAtTextViewDemo
//
//  Created by pengli on 2018/5/24.
//  Copyright © 2018年 pengli. All rights reserved.
//

import UIKit

class LPAtListController: UITableViewController {
    lazy var ats: [(id: Int, name: String)] = {
        return [(100000, "Swift"),
                (100001, "Objective-C"),
                (100002, "C/C++"),
                (100003, "Java"),
                (100004, "C#")]
    }()
    
    var selectedBlock: (((id: Int, name: String)) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "LPAtCell")
        
        let backButton = UIBarButtonItem(title: "取消",
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LPAtCell",
                                                 for: indexPath)
        cell.textLabel?.text = ats[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedBlock?(ats[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
