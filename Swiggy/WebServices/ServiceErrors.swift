//
//  ServiceErrors.swift
//  Swiggy
//
//  Created by Namit on 25/10/18.
//  Copyright © 2018 Namit. All rights reserved.
//

import Foundation

enum ServiceError:Error{
    case responseEmpty
    case typeCastingNotOk
    case serverError(Data?)
}
