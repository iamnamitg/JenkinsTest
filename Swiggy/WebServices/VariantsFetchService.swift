//
//  VariantsFetchService.swift
//  Swiggy
//
//  Created by Namit on 25/10/18.
//  Copyright © 2018 Namit. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import AlamofireObjectMapper

struct VariantsFetchService{
    func execute() -> Promise<VariantsModel>{
        return Promise<VariantsModel>() { seal in
            let requestURL = "https://api.myjson.com/bins/e154s"
            Alamofire.request(requestURL).responseObject {
                (response:DataResponse<VariantsModel>) in
                 if let statusCode = response.response?.statusCode{
                    switch (statusCode){
                    case 200..<300:
                        if let variations:VariantsModel = response.result.value{
                            seal.fulfill(variations)
                        }else{
                            seal.reject(ServiceError.typeCastingNotOk)
                        }
                        break
                    default:
                        seal.reject(ServiceError.serverError(response.data))
                        break
                    }
                }else{
                    seal.reject(ServiceError.responseEmpty)
                }
            }
        }
    }
}
