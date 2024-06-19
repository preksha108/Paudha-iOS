//
//  AuthViewModel.swift
//  PaudhaUI
//
//  Created by user1 on 20/03/24.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    
}
