//
//  Random.swift
//  slack
//
//  Created by Sergei Perevoznikov on 05/12/2016.
//
//
import Foundation

private let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

public class Random {
    public static func number(length len: Int = 16) -> Int {
        var rand: Int = 0
        #if os(Linux)
            rand = Int(random() % len)
        #else
            rand = Int(arc4random_uniform(UInt32(len)))
        #endif
        return rand
    }
    
    public static func string(length len: Int = 16) -> String {
        let length = letters.characters.count
        
        var randomString: String = ""
        for _ in 1...len {
            let rand: Int = number(length: length)
            let index = letters.index(letters.startIndex, offsetBy: rand)
            let character = letters[index]
            randomString.append(character)
        }
        
        return randomString
    }
    
    public static func requestId() -> String {
        return string()
    }
}
