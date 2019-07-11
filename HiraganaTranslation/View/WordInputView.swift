//
//  WordInputView.swift
//  HiraganaTranslation
//
//  Created by 山田卓史 on 2019/07/11.
//  Copyright © 2019 TAKASHI YAMADA. All rights reserved.
//

import Foundation
import UIKit

protocol WordInputViewDelegate: class {
    func wordInputView(wordEditting view: WordInputView, text: String)
    func wordInputView(sendButtonDidTap view: WordInputView)
}

class WordInputView: UIView {
    
    private var label: UILabel!                 //説明
    private var wordTextField: UITextField!     //タスク内容を入力するUITextField
    private var sendButton: UIButton!           //送信ボタン
    
    //デリゲート
    weak var delegate: WordInputViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //説明
        label = UILabel()
        label.text = "日本語文字列をひらがなに変換します"
        addSubview(label)
        
        //入力フィールド
        wordTextField = UITextField()
        wordTextField.delegate = self
        wordTextField.tag = 0
        wordTextField.placeholder = "日本語の文章を入力してください"
        addSubview(wordTextField)
        
        
        //送信ボタン
        sendButton = UIButton()
        sendButton.setTitle("変換する", for: .normal)
        sendButton.setTitleColor(UIColor.black, for: .normal)
        sendButton.layer.borderWidth = 0.5
        sendButton.layer.cornerRadius = 4.0
        sendButton.addTarget(self, action: #selector(sendButtonTapped(_:)), for: .touchUpInside)
        addSubview(sendButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let posX = bounds.origin.x + 30;
        
        //位置サイズ調整
        label.frame = CGRect(x: posX,
                             y: bounds.origin.y + 10,
                             width: bounds.size.width - 60,
                             height: 50.0)
        
        //位置サイズ調整
        wordTextField.frame = CGRect(x: posX,
                                     y: bounds.origin.y + 60,
                                     width: bounds.size.width - 60,
                                     height: 50.0)
        
        //位置サイズ調整
        let sendButtonSize = CGSize(width: 100, height: 50)
        sendButton.frame = CGRect(x: posX,
                                  y: wordTextField.frame.maxY + 20,
                                  width: sendButtonSize.width,
                                  height: sendButtonSize.height)
        
    }
    
    @objc func sendButtonTapped(_ sender: UIButton) {
        delegate?.wordInputView(sendButtonDidTap: self)
    }
}

extension WordInputView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //親に送信
        delegate?.wordInputView(wordEditting: self, text: textField.text ?? "")
        
        return true
    }
}

