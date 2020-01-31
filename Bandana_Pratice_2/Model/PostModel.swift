//
//  PostModel.swift
//  Bandana_AI_Eng_IOS
//
//  Created by Swaminath Kosetty on 30/01/20.
//  Copyright © 2020 Ojas. All rights reserved.
//

import Foundation
import UIKit

class PostModel {
    var title = String()
    var createdDate = String()
    var switchStatus = false
    
    init(postModel:NSDictionary) {
         let _highlightResultData = postModel["_highlightResult"] as! NSDictionary
         if let aTitle = (_highlightResultData.object(forKey: serverkeys.title) as! NSDictionary).object(forKey: "value"){
            self.title = aTitle as! String
        }
       
        if let acreatedDate = postModel.object(forKey: serverkeys.createdDate){
            self.createdDate = acreatedDate as! String
        }
        
    }
}
