//
//  ResultView.swift
//  HiraganaTranslation
//
//  Created by 山田卓史 on 2019/07/11.
//  Copyright © 2019 TAKASHI YAMADA. All rights reserved.
//

import Foundation
import UIKit

class ResultView: UIView {
    
    private var senetenseTxt: String?
    private var convertedTxt: String?
    
    private var sectionLbl1: UILabel!                 //説明
    private var sectionLbl2: UILabel!                 //説明
    private var senetenseLbl: UILabel!                 //説明
    private var convertedLbl: UILabel!                 //説明
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame: CGRect, senetense:String, converted: String) {
        self.init(frame: frame)
        self.senetenseTxt = senetense
        self.convertedTxt = converted
        
        //見出し
        sectionLbl1 = UILabel()
        sectionLbl1.text = "変換前:"
        addSubview(sectionLbl1)
        
        //変換前
        senetenseLbl = UILabel()
        senetenseLbl.text = senetenseTxt
        addSubview(senetenseLbl)
        
        //見出し
        sectionLbl2 = UILabel()
        sectionLbl2.text = "変換後:"
        addSubview(sectionLbl2)
        
        //変換前
        convertedLbl = UILabel()
        convertedLbl.text = convertedTxt
        addSubview(convertedLbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let posX = bounds.origin.x + 30;
        
        //位置サイズ調整
        sectionLbl1.frame = CGRect(x: posX,
                                   y: bounds.origin.y + 80,
                                   width: bounds.size.width - 60,
                                   height: 50.0)
        
        //位置サイズ調整
        senetenseLbl.frame = CGRect(x: posX,
                                    y: sectionLbl1.frame.maxY,
                                    width: bounds.size.width - 60,
                                    height: 50.0)
        
        //位置サイズ調整
        sectionLbl2.frame = CGRect(x: posX,
                                   y: senetenseLbl.frame.maxY + 50,
                                   width: bounds.size.width - 60,
                                   height: 50.0)
        
        //位置サイズ調整
        convertedLbl.frame = CGRect(x: posX,
                                    y: sectionLbl2.frame.maxY,
                                    width: bounds.size.width - 60,
                                    height: 50.0)
    }
}
