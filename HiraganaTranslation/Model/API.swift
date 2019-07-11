//
//  API.swift
//  GitHubClientTest
//
//  Created by 山田卓史 on 2019/07/10.
//  Copyright © 2019 TAKASHI YAMADA. All rights reserved.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case unknown
    case invalidURL
    case invalidResponse
    
    var description: String {
        switch self {
        case .unknown: return "不明なエラーです"
        case .invalidURL: return "無効なURLです"
        case .invalidResponse: return "フォーマットが無効なレスポンスを受け取りました"
        }
    }
}

class API {
    
    func getTranslation(text: String, success: @escaping(Word) -> Void, failure: @escaping (Error) -> Void) {
        let requestURL = URL(string: "https://labs.goo.ne.jp/api/hiragana")
        print("送信前:\(text)")

        guard let url = requestURL else {
            failure(APIError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        let app_id = "28df06568839a6d83b1ecb23d776f9cea358a66f6ed5f352556664bcd522a4cb"
        let newParams: [String: Any] = ["app_id": app_id, "sentence": text, "output_type": "hiragana"]
        
        let params: Data
        do {
            params = try JSONSerialization.data(withJSONObject: newParams, options: [])
            request.httpBody = params
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            //エラー
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            //データがない
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                
                return
            }
            
            //不正
            guard let jsonOptional = try? JSONSerialization.jsonObject(with: data, options: []),
                let json = jsonOptional as? [String: Any]
                else {
                    DispatchQueue.main.async {
                        failure(APIError.invalidResponse)
                    }
                    return
            }
            
            
            //jsonからUserを作成後、クロージャーで返す
            let wData = Word(beforeText: text, attributes: json)
            
            DispatchQueue.main.async {
                success(wData)
            }
            
        }
        
        task.resume()
    }
}
