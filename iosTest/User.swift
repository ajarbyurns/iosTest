//
//  User.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import Foundation

struct User {
   
    var email = ""
    var firstName = ""
    var lastName = ""
    var avatarLink = ""
    var fullName = ""
    
    init(input: Dictionary<String, String>){
        email = input["email"] ?? ""
        firstName = input["first_name"] ?? ""
        lastName = input["last_name"] ?? ""
        avatarLink = input["avatar"] ?? ""
        fullName = firstName + lastName
    }
    
}
