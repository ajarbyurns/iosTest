//
//  User.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import Foundation
import UIKit

struct User {
   
    var email = ""
    var firstName = ""
    var lastName = ""
    var avatarLink = ""
    var fullName = ""
    
    init(input: Dictionary<String, Any>){
        email = input["email"] as? String ?? ""
        firstName = input["first_name"] as? String ?? ""
        lastName = input["last_name"] as? String ?? ""
        avatarLink = input["avatar"] as? String ?? ""
        fullName = firstName + lastName
    }
    
}
