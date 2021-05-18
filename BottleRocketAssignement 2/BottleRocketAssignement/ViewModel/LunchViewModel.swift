//
//  LunchViewModel.swift
//  BottleRocketAssignement
//
//  Created by Hassan Baraka on 4/13/21.
//

import Foundation


struct LunchViewModel: Codable {
    let name: String
    let backgroundImageURL: String
    let category: String
    let contact: Contact?
    
    init(with model:Restaurant){
        name = model.name
        backgroundImageURL = model.backgroundImageURL
        category = model.category
        contact = model.contact
    }
}
