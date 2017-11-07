//
//  GifData.swift
//  TestClean
//
//  Created by Jura Moshkov on 05/11/2017.
//  Copyright © 2017 Jura Moshkov. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

class GifData: Object, Mappable {
    @objc dynamic var url: String!
    @objc dynamic var id: String!
    
    required init?(map: Map) {
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["images.fixed_height.url"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
