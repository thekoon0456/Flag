//
//  ContactDetailFeature.swift
//  Flag
//
//  Created by Deokhun KIM on 7/12/24.
//

import ComposableArchitecture

@Reducer
struct ContactDetailFeature {
    struct State: Equatable {
        let contact: Contact
    }
    
    enum Action: Equatable {
        
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}

