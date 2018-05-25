//
//  UIPasteboard+LPTextView.swift
//  LPTextView
//
//  Created by pengli on 2018/5/25.
//  Copyright © 2018年 pengli. All rights reserved.
//

import UIKit.UIPasteboard

private let LPRegulaPattern = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"
public extension UIPasteboard {
    static let LPPBAttrStr: String = "com.lp.LPTextView.pasteboard.attrStr"
    
    /// 为UIPasteboard扩展粘贴富文本功能
    /// 注：富文本主要包含LPTextAttachment和@用户
    var lp_attributedString: NSAttributedString? {
        get {
            print("items=\(items)")
            for item in items {
                print("item=\(item)")
                
                let data = item[UIPasteboard.LPPBAttrStr] as? Data
                print("data=\(data)")
                if let data = data {
                    let obj = NSKeyedUnarchiver.unarchiveObject(with: data)
                    print("obj=\(obj)")
                    print("obj->[String: Any]=\(obj as? [String: Any])")
                    
//                    if let attrString = attributedString(with: dict) {
//                        return attrString
//                    }
                }
            }
            
            guard let string = string else { return nil }
            return NSAttributedString(string: string)
        }
        
        set {
            guard let newValue = newValue else { return }
            setPastboard(with: newValue)
        }
    }
    
    private func attributedString(with dict: [String: Any]) -> NSAttributedString? {
        guard let mutableAttrString = dict["LPAttrString"] as? NSMutableAttributedString else {
            return nil
        }
       
        guard let emotions = dict["LPEmotions"] as? [String: Any]
            , emotions.count > 0 else {
            return mutableAttrString
        }
        
        print("------\(emotions)")
        
        for emotion in emotions {
            
            
//            let key = NSAttributedStringKey.LPEmotionID
//            let range = NSRange(location: 0, length: mutableAttrString.length)
//            let options = NSAttributedString.EnumerationOptions.reverse
//            mutableAttrString.enumerateAttribute(key, in: range, options: options) { (obj, range, stop) in
//                print("lfjl;dsfjdsl;fdslfj=\(obj)")
//                if let obj = obj as? LPTextAttachment {
////                    let value = emotion.value
////                    if let image = value.image {
////                        let attachment = LPTextAttachment(image: image,
////                                                          scale: value.imageScale,
////                                                          alignment: value.alignment,
////                                                          tag: value.placeholder,
////                                                          font: value.font)
//                        mutableAttrString.removeAttribute(key, range: range)
//                        let attrString = NSAttributedString(attachment: obj)
//                        mutableAttrString.replaceCharacters(in: range, with: attrString)
//                    }
////                }
//            }
        }
        return mutableAttrString
    }
    
    private func setPastboard(with attrString: NSAttributedString) {
        let result = attrString.lp_parseEmotion()
        
        string = result.attrString.string
        
        var dict: [String: Any] = ["LPAttrString": result.attrString]
        if let emotions = result.emotions, emotions.count > 0 {
            var et: [String: Any] = [:]
            for a in emotions {
//                et["objc"] = a
                et["img"] = a.value.image!
            }
            dict["LPEmotions"] = et
        }
        
        print("dict=\(dict)")
        
        let data = NSKeyedArchiver.archivedData(withRootObject: dict)
        
        print("data=\(data)")
        addItems([[UIPasteboard.LPPBAttrStr: data]])
        
        print("items=\(items)")
    }
}
