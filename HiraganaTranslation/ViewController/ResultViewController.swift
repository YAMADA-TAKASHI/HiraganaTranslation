//
//  ResultViewController.swift
//  HiraganaTranslation
//
//  Created by 山田卓史 on 2019/07/11.
//  Copyright © 2019 TAKASHI YAMADA. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    fileprivate var resultView: ResultView!

    private var senetenseTxt: String
    private var convertedTxt: String
    
    init(senetense: String, converted: String) {
        self.senetenseTxt = senetense
        self.convertedTxt = converted
        
        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white

        resultView = ResultView(frame: view.frame, senetense: senetenseTxt, converted: convertedTxt)
        view.addSubview(resultView)
    }
}
