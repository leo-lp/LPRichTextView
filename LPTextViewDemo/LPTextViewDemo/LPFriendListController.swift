//
//  LPFriendListController.swift
//  LPAtTextViewDemo
//
//  Created by pengli on 2018/5/24.
//  Copyright © 2018年 pengli. All rights reserved.
//

import UIKit

class LPFriendListController: UITableViewController {
    lazy var friends: [(id: Int, name: String)] = {
        return [(100000, "鸣人"),
                (100001, "天罚"),
                (100002, "阿罪"),
                (100003, "佐助"),
                (100004, "青龙")]
    }()
    
    var selectedBlock: (((id: Int, name: String)) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "LPFriendCell")
        
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
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LPFriendCell",
                                                 for: indexPath)
        cell.textLabel?.text = friends[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedBlock?(friends[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
