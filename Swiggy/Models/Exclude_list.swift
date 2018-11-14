
import Foundation
import ObjectMapper

struct Exclude_list : Mappable {
	var group_id : String?
	var variation_id : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		group_id <- map["group_id"]
		variation_id <- map["variation_id"]
	}

}
