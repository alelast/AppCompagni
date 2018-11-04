//
//  Compagni.swift
//  AppCompagniBanco
//
//  Created by Alessio Lasta on 18/10/18.
//  Copyright © 2018 Alessio Lasta. All rights reserved.
//
import UIKit
import RealmSwift

@objcMembers class Compagno: Object {
    
     dynamic var id : String!
    dynamic var image : Data?
    dynamic var name : String?
    dynamic var surname : String?
    /*dynamic var star1 : String?
    dynamic var star2 : String?
    dynamic var star3 : String?
    dynamic var star4 : String?
    dynamic var star5 : String?*/
    dynamic var stars : String?

    
    convenience init(name : String? = nil, surname: String? = nil, image: Data? = nil, star1: String? = nil, star2: String? = nil, star3: String? = nil, star4: String? = nil, star5: String? = nil, stars: String? = nil) {
        self.init()
        
        
        self.id = UUID().uuidString
        self.name = name
        self.surname = surname
        self.image = image
        /*self.star1 = star1
         self.star2 = star2
         self.star3 = star3
         self.star4 = star4
         self.star5 = star5*/
        self.stars = stars
        
    }
    
    
    func changeData(in realm: Realm = try! Realm(configuration: RealmUtils.config), name : String? = nil, surname: String? = nil, image: Data? = nil, star1: String? = nil, star2: String? = nil, star3: String? = nil, star4: String? = nil, star5: String? = nil, compagno: Compagno? = nil, stars: String? = nil) {
        do {
            try realm.write {
                
                self.image = image ?? compagno?.image ?? self.image
                self.name = name ?? compagno?.name ?? self.name
                self.surname = surname ?? compagno?.surname ?? self.surname
                /*self.star1 = star1 ?? compagno?.star1 ?? self.star1
                 self.star2 = star2 ?? compagno?.star2 ?? self.star2
                 self.star3 = star3 ?? compagno?.star3 ?? self.star3
                 self.star4 = star4 ?? compagno?.star4 ?? self.star4
                 self.star5 = star5 ?? compagno?.star5 ?? self.star5*/
                self.stars = stars ?? compagno?.stars ?? self.stars
            }
        }catch {}
        
    }
    
    
    
    func getName() -> String {
        return self.name ?? ""
    }
    
    func getSurname() -> String {
        return self.surname ?? ""
    }
    
    func getStars() -> String {
        /*var variabile = 0
        if star1 == "★" {
            variabile += 1
        }
        if star2 == "★" {
            variabile += 1
        }
        if star3 == "★" {
            variabile += 1
        }
        if star4 == "★" {
            variabile += 1
        }
        if star5 == "★" {
            variabile += 1
        }*/
        
        return self.stars ?? "0"
    }
    
    func getImage() -> Data?{
        return self.image
    }
    
    func add(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {}
    }
    func remove(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch {}
    }
    
    
    
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Compagno] {
        return Array(realm.objects(Compagno.self))
    }

    override static func primaryKey() -> String? {
        return "id"
    }
    static func readUser(in realm: Realm = try! Realm(configuration: RealmUtils.config), withid: String) -> Compagno? {
        return realm.object(ofType: Compagno.self, forPrimaryKey: withid)
    }
    
}
