//
//  EmojiHelper.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 09.03.2022.
//

import Foundation

struct EmojiHelper {
    static private let superheroes = ["π¦ΈββοΈ", "π¦Έπ»", "π¦ΈπΌ", "π¦Έπ½", "π¦ΈπΎ", "π¦ΈπΏ", "π¦ΈββοΈ", "π¦Έπ»ββοΈ", "π¦ΈπΌββοΈ", "π¦Έπ½ββοΈ", "π¦ΈπΎββοΈ", "π¦ΈπΏββοΈ", "π¦ΈββοΈ", "π¦Έπ»ββοΈ", "π¦ΈπΌββοΈ", "π¦Έπ½ββοΈ", "π¦ΈπΎββοΈ", "π¦ΈπΏββοΈ"]
    
    /// Help to  generate 3 various emoji of superheroes
    static var prefix: String { superheroes.shuffled().prefix(upTo: 3).joined() }
}
