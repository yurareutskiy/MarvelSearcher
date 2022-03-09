//
//  String+MD5.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 21.02.2022.
//

import Foundation
import CryptoKit

extension String {
    
    /// Return transformed string using MD5
    var md5Hash: String? {
        guard let data = self.data(using: .utf8) else { return nil }
        let digest = Insecure.MD5.hash(data: data)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
