//
//  BaseResponseModel.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 21.02.2022.
//

import Foundation

struct BaseResponseModel<T: Codable>: Codable {
    var code: Int
    var status: String
    var data: BaseResponseDataModel<T>
}

struct BaseResponseDataModel<T: Codable>: Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: Array<T>
}
