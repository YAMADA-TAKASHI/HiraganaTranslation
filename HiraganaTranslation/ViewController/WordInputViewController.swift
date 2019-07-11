//
//  WordInputViewController.swift
//  HiraganaTranslation
//
//  Created by 山田卓史 on 2019/07/11.
//  Copyright © 2019 TAKASHI YAMADA. All rights reserved.
//

import Foundation
import UIKit

class WordInputViewController: UIViewController {
    
    fileprivate var wordInputView: WordInputView!
    
    fileprivate var viewModel: WordInputViewModel!
    fileprivate var tableView: UITableView!
    fileprivate var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        wordInputView = WordInputView()
        wordInputView.delegate = self
        view.addSubview(wordInputView)
    }
    
    override func viewDidLayoutSubviews() {
        
        wordInputView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                      height: view.frame.size.height - view.safeAreaInsets.bottom)

    }
}

extension WordInputViewController: WordInputViewDelegate {
    
    func wordInputView(wordEditting view: WordInputView, text: String) {
        print("編集中:\(text)")
    }
    
    func wordInputView(sendButtonDidTap view: WordInputView) {
        print("送信！！")
    }
    
    
}
