//
//  Store.swift
//  AtlysProject
//
//  Created by Keertika on 28/11/25.
//

import Foundation


class Store: ObservableObject {
    @Published var items: [Item]
    
    init(images: [String]) {
        items = images.enumerated().map { index, name in
            Item(id: index, title: name, image: name)
        }
    }
}
