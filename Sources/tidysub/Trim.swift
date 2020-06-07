//
//  Trim.swift
//  tidy sub
//
//  Created by Apollo Zhu on 6/7/20.
//  Copyright © 2020 Apollo nyan~. MIT License.
//

import Foundation
import Pangu_Swift

extension CharacterSet {
    fileprivate static let nonEssential
        = CharacterSet(charactersIn: "，。、")
            .union(.whitespacesAndNewlines)
}

public func format(_ line: String) -> String {
    return line.trimmingCharacters(in: .nonEssential)
        .spaced
        .replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
        .replacingOccurrences(of: "“ ", with: "“")
        .replacingOccurrences(of: " ”", with: "”")
        .replacingOccurrences(of: #"<(\S+) >"#, with: "<$1>", options: .regularExpression)
}
