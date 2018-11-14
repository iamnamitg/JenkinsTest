

import Foundation
import ObjectMapper

struct VariantsModel : Mappable {
	var variants : Variants?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		variants <- map["variants"]
	}

}
