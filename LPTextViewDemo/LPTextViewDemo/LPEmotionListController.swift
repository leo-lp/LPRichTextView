//
//  LPEmotionListController.swift
//  LPTextViewDemo
//
//  Created by pengli on 2018/5/25.
//  Copyright © 2018年 pengli. All rights reserved.
//

import UIKit

class LPEmotionListController: UITableViewController {
    private var emotes: [(LPEmotionID, LPEmotionName)] = []
    var selectedBlock: (((LPEmotionID, LPEmotionName)) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "LPEmotionCell")
        
        DispatchQueue.global().async {
            let emotes = LPEmotion.shared.emojis.sorted { $0.0 < $1.0 }
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                self.emotes = emotes
                self.tableView.reloadData()
            }
        }
        
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
        return emotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LPEmotionCell", for: indexPath)
        let emote = emotes[indexPath.row]
        cell.imageView?.image = LPEmotion.shared.emoji(by: emote.0)
        cell.textLabel?.text = "ID:\(emote.0)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedBlock?(emotes[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
