//
//  Recommendations.swift
//  tidy sub
//
//  Created by Apollo Zhu on 6/7/20.
//  Copyright © 2020 Apollo nyan~. MIT License.
//

import Foundation
import Pangu_Swift

extension CharacterSet {
    fileprivate static let nonEssential = CharacterSet(charactersIn: "，。、")
}

public func format(_ line: String) -> String {
  return line.trimmingCharacters(in: .nonEssential)
    .spaced
    .replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
    .replacingOccurrences(of: "“ ", with: "“")
    .replacingOccurrences(of: " ”", with: "”")
    .replacingOccurrences(of: #"<(\S+) >"#, with: "<$1>", options: .regularExpression)
}

extension String {
  public var displayWidth: Int {
    return reduce(0, { $0 + ($1.utf8.count == 3 ? 2 : 1) })
  }
}