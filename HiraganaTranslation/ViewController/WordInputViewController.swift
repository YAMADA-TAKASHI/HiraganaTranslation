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
    fileprivate var inputTxt: String?

    fileprivate var viewModel: WordInputViewModel!
    
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
        
        inputTxt = text
    }
    
    func wordInputView(sendButtonDidTap view: WordInputView) {
        
        viewModel = WordInputViewModel()
        viewModel.stateDidupdate = {[weak self] state in
            switch state {
            case .loading:  //通信中

                break
                
            case .finish:   //通信完了
                
                let sentense = self?.viewModel.sentenseText()
                let converted = self?.viewModel.convertedText()
                print("変換前:\(sentense!) 変換後:\(converted!)")
                
                //画面遷移して返還後のテキストを表示
                
                break
                
            case .error(let error): //エラー
                
                let alertController = UIAlertController(title: error.localizedDescription,
                                                        message: nil,
                                                        preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK",
                                                style: .cancel,
                                                handler: nil)
                alertController.addAction(alertAction)
                self?.present(alertController, animated: true, completion: nil)
                break
            }
        }
        
        //ユーザー一覧を取得
        viewModel.getTranslation(transword: inputTxt!)
    }
    
    
}
