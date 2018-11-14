//
//  PizzaSelectionUsecase.swift
//  Swiggy
//
//  Created by Namit on 25/10/18.
//  Copyright © 2018 Namit. All rights reserved.
//

import Foundation
import PromiseKit

class PizzaSelectionUsecase{
    let fetchService = VariantsFetchService()
    
    func fetchVairations() -> Promise<VariantsModel>{
        return fetchService.execute()
    }
}
