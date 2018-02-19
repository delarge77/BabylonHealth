//
//  DataRequest+Request.swift
//  BabylonHealth
//
//  Created by Alessandro dos Santos Pinto on 16/05/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    @discardableResult
    func responseArray(completion: @escaping (APIResult<NSArray>) -> Void) -> Self {
        return responseJSON { response in
            guard let httpResponse = response.response else {
                completion( .error( .requestFailed))
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = response.data {
                    guard let object = try? JSONSerialization.jsonObject(with:data),
                        let json = object as? NSArray else {
                            completion( .error( .jsonConversionFailure))
                            return
                    }
                    completion( .success(json))
                }
            } else {
                completion( .error( .responseUnsuccessful))
            }
        }
    }
	
	@discardableResult
	func responseData(completion: @escaping (APIResult<Data>) -> Void) -> Self {
		return responseJSON { response in
			guard let httpResponse = response.response else {
				completion( .error( .requestFailed))
				return
			}
			if httpResponse.statusCode == 200 {
				if let data = response.data {
					completion( .success(data))
				} else {
					completion( .error( .responseUnsuccessful))
				}
			} else {
				completion( .error( .responseUnsuccessful))
			}
		}
	}
}
