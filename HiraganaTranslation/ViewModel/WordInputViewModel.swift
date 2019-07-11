//
//  WordInputViewModel.swift
//  HiraganaTranslation
//
//  Created by 山田卓史 on 2019/07/11.
//  Copyright © 2019 TAKASHI YAMADA. All rights reserved.
//

import Foundation
import UIKit

/*
 現在通信中か、通信が成功したのか、通信が失敗したのかの状態をenumで適宜
 */

enum ViewModelState {
    case loading
    case finish
    case error(Error)
}

final class WordInputViewModel {
    
    /*
     ViewModelStateをClosureとしてpropertyで保持
     この変数がViewControllerに対して通知を送る役割を果たす
     */
    var stateDidupdate: ((ViewModelState) -> Void)?
    
    //Wordのレスポンスデータ
    private var wData: Word?
    
    //モデル層で定義したAPIクラスを変数として保持
    let api = API()
    
    //Userの配列を取得する
    func getTranslation(transword text: String) {
        
        //.loading通知を送る
        stateDidupdate?(.loading)
        
        api.getTranslation(text: text, success: { (data) in
            
            //受け取り
            self.wData = data
            
            //通信が成功したので、.finish通知を送る
            self.stateDidupdate?(.finish)
            
        })
        { (error) in
            //通信が失敗したので、.crror通知を送る
            self.stateDidupdate?(.error(error))
            
        }
    }
    
    
    func sentenseText() -> String {
        return wData?.sentence ?? ""
    }
    
    func convertedText() -> String {
        return wData?.converted ?? ""
    }
}
