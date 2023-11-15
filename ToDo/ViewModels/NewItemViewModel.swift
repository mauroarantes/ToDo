//
//  NewItemViewModel.swift
//  ToDo
//
//  Created by Mauro Arantes on 14/11/2023.
//

import Foundation

class NewItemViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var isComplete = false
    
}
