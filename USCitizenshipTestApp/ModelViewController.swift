//
//  ModelViewControllers.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case otherError
    case noData
}

class ModelViewController {
    
    init() {
        self.imageSetUp()
    }
    
    var imgURL = "https://www.dongwoopae.com/resources/img/"

    var imgUrlArray = [String]()
    
    func imageSetUp() {
    for i in 1..<6 {
        let imgURLs = imgURL + "\(i).jpg"
        imgUrlArray.append(imgURLs)
        }
    }
    
    func fetchImages(imgUrlString: String, completion:@escaping (Result<Data, NetworkError>)-> Void) {
        
        let imageUrl = URL(string: imgUrlString)!
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            print(data)
            completion(.success(data))
        }.resume()
    }
}
