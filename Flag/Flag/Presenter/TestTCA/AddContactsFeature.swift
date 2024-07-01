//
//  AddContactsFeature.swift
//  Flag
//
//  Created by Deokhun KIM on 7/1/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddContactFeature {
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .none
            case .saveButtonTapped:
                return .none
            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}
