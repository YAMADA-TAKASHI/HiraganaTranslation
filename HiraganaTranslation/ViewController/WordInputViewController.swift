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
    
    //タスクが未入力時のアラート
    fileprivate func showMissingTextAlert() {
        let alertController = UIAlertController(title: "テキストを入力してください", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
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
                
                //変換ボタンを押せないように
                self?.wordInputView.setSendButtonEnabled(false)
                
                break
                
            case .finish:   //通信完了
                
                //変換ボタンを押せるように
                self?.wordInputView.setSendButtonEnabled(true)
                
                let sentense = self?.viewModel.sentenseText()
                let converted = self?.viewModel.convertedText()
                print("変換前:\(sentense!) 変換後:\(converted!)")
                
                //画面遷移して返還後のテキストを表示
                let controller = ResultViewController(senetense: sentense!, converted: converted!)
                self?.navigationController?.pushViewController(controller, animated: true)
                
                break
                
            case .error(let error): //エラー
                
                //変換ボタンを押せるように
                self?.wordInputView.setSendButtonEnabled(true)
                
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
        
        guard let inputTxt = inputTxt else {
            showMissingTextAlert()
            return
        }
        
        //長さが足りない
        if inputTxt.count <= 0 {
            showMissingTextAlert()
            return
        }
        
        
        //ユーザー一覧を取得
        viewModel.getTranslation(transword: inputTxt)
    }
    
    
}
