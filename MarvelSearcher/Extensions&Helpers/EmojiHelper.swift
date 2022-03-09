//
//  EmojiHelper.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 09.03.2022.
//

import Foundation

struct EmojiHelper {
    static private let superheroes = ["🦸‍♀️", "🦸🏻", "🦸🏼", "🦸🏽", "🦸🏾", "🦸🏿", "🦸‍♂️", "🦸🏻‍♂️", "🦸🏼‍♂️", "🦸🏽‍♂️", "🦸🏾‍♂️", "🦸🏿‍♂️", "🦸‍♀️", "🦸🏻‍♀️", "🦸🏼‍♀️", "🦸🏽‍♀️", "🦸🏾‍♀️", "🦸🏿‍♀️"]
    
    /// Help to  generate 3 various emoji of superheroes
    static var prefix: String { superheroes.shuffled().prefix(upTo: 3).joined() }
}
