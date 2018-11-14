

import Foundation
import ObjectMapper

struct Variant_groups : Mappable {
	var group_id : String?
	var name : String?
	var variations : [Variations]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		group_id <- map["group_id"]
		name <- map["name"]
		variations <- map["variations"]
	}

}
