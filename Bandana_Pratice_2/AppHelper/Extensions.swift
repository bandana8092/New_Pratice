//
//  Extensions.swift
//  Bandana_Pratice_2
//
//  Created by Rakesh Nangunoori on 31/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import Foundation
import UIKit

extension String{
    func convertdateToFormate(formate:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = formate
        return  dateFormatter.string(from: date!)
    }
    
}


