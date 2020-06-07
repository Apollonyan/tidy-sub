//
//  Width.swift
//  tidy sub
//
//  Created by Apollo Zhu on 6/7/20.
//  Copyright © 2020 Apollo nyan~. MIT License.
//

private let special: Set<String> = [
    "本字幕由志愿者义务贡献，采用许可协议",
    "知识共享 署名—非商业性使用—相同方式共享 3.0 美国"
]

extension String {
    public var displayWidth: Int {
        guard !special.contains(self) else { return 1 }
        return reduce(0, { $0 + ($1.utf8.count == 3 ? 2 : 1) })
    }
}
