//
//  LPHomeViewController.swift
//  LPAtTextViewDemo
//
//  Created by pengli on 2018/5/24.
//  Copyright © 2018年 pengli. All rights reserved.
//

import UIKit
import LPTextView

class LPHomeViewController: UIViewController {
    @IBOutlet weak var textView: LPAtTextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.tvDelegate = self
        textView.textLines(min: 1, max: 4)
        textView.isAtEnabled = true
        
        let placeholder = "说点什么..."
        let attributes: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.brown]
        textView.placeholder = NSAttributedString(string: placeholder,
                                                  attributes: attributes)
        
        textView.layer.borderColor = #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1).cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 4.0
        
        
        let right = UIBarButtonItem(barButtonSystemItem: .camera,
                                    target: self,
                                    action: #selector(cameraButtonClicked))
        navigationItem.rightBarButtonItem = right
        right.isEnabled = false
    }
    
    @objc func cameraButtonClicked(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        let emoteVc = LPEmotionListController(style: .grouped)
        emoteVc.selectedBlock = { emote in
            guard let img = LPEmotion.shared.emoji(by: emote.0) else { return }
            let attachment = LPTextAttachment(image: img, tag: emote.0)
            self.textView.insertEmotion(attachment)
        }
        let navCtrl = UINavigationController(rootViewController: emoteVc)
        present(navCtrl, animated: true, completion: nil)
    }
    
    @IBAction func atButtonClicked(_ sender: UIButton) {
        let friendVc = LPFriendListController(style: .grouped)
        friendVc.selectedBlock = { friend in
            self.textView.insertUser(withID: friend.id,
                                     name: friend.name,
                                     checkAt: nil)
        }
        let navCtrl = UINavigationController(rootViewController: friendVc)
        present(navCtrl, animated: true, completion: nil)
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        let result = textView.textStorage.lp_parse { (index, _) -> String in
            return "@{\(index)}"
        }
        textView.clearTextStorage()
        
        print(result.description)
    }
}

extension LPHomeViewController: LPTextViewDelegate {
    
    /// 当textView文本改变之后调用
    func textView(_ textView: UITextView,
                  didProcessEditing editedRange: NSRange,
                  changeInLength delta: Int) {
        navigationItem.rightBarButtonItem?.isEnabled = textView.text.count > 0
    }
    
    /// 当textView高度改变之后调用
    func textView(_ textView: UITextView,
                  heightDidChange newHeight: CGFloat) {
        print("newHeight=\(newHeight)")
        textViewHeightConstraint.constant = newHeight
    }
    
    /// 当textView输入@字符后调用
    func textView(_ textView: UITextView,
                  inputAtCharacter character: String) {
        let friendVc = LPFriendListController(style: .grouped)
        friendVc.selectedBlock = { friend in
            self.textView.insertUser(withID: friend.id,
                                     name: friend.name,
                                     checkAt: character)
        }
        let navCtrl = UINavigationController(rootViewController: friendVc)
        present(navCtrl, animated: true, completion: nil)
    }
}
