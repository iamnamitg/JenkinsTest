

import Foundation
import ObjectMapper

struct Variations : Mappable {
	var name : String?
	var price : Int?
	var id : String?
	var inStock : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		name <- map["name"]
		price <- map["price"]
		id <- map["id"]
		inStock <- map["inStock"]
	}

}
