//
//  Word.swift
//  HiraganaTranslation
//
//  Created by 山田卓史 on 2019/07/11.
//  Copyright © 2019 TAKASHI YAMADA. All rights reserved.
//

import Foundation

final class Word {
    let request_id: String
    let output_type: String
    let sentence: String
    let converted: String
    
    init(beforeText before: String, attributes: [String: Any]) {
        sentence = before;
        request_id =  attributes["request_id"] as! String
        output_type = attributes["output_type"] as! String
        converted = attributes["converted"] as! String
    }
}
