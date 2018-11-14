

import Foundation
import ObjectMapper

struct Variants : Mappable {
	var variant_groups : [Variant_groups]?
	var exclude_list : [[Exclude_list]]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		variant_groups <- map["variant_groups"]
		exclude_list <- map["exclude_list"]
	}

}
