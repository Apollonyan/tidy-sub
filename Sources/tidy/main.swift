//
//  main.swift
//  ClearENSub
//
//  Created by Liuliet.Lee on 26/5/2020.
//  Copyright © 2020 Liuliet.Lee. All rights reserved.
//

import srt

/// 中文字幕文件路径
let cnSubFilePath = "<#CS193p-Developing-Apps-for-iOS-Spring-2020/subtitles/zh-Hans/Lecture 1. Course Logistics and Introduction to SwiftUI.srt#>"

/// 英文字幕文件路径
let enSubFilePath = "<#CS193p-Developing-Apps-for-iOS-Spring-2020/subtitles/en/Lecture 1. Course Logistics and Introduction to SwiftUI.srt#>"

/// 输出文件路径
let outputFilePath = "<#filtered cn sub.srt#>"

/**
 开始和结束处理条数，从 1 开始

 如果整个文件都需要处理则将其设定为 0
 */
var startIndex = 304, endIndex = 453

guard let cnSub = try? SRT(path: cnSubFilePath) else {
    fatalError("Cannot load file \(cnSubFilePath)")
}

guard let enSub = try? SRT(path: enSubFilePath) else {
    fatalError("Cannot load file \(enSubFilePath)")
}

startIndex -= 1

if startIndex == -1 && endIndex == -1 {
    startIndex = 0
    endIndex = cnSub.segments.count
} else if !(0 <= startIndex && 0 <= endIndex && startIndex < endIndex && endIndex <= cnSub.segments.count) {
    fatalError("Index error")
}

let cnSegments = cnSub.segments as! [SRT.Segment]
let enSegments = enSub.segments as! [SRT.Segment]

let filteredSegments = cnSegments.enumerated().map { (i, segment) -> SRT.Segment in
    if startIndex <= i, i < endIndex {
        let filteredContents = segment.contents.filter {
            !enSegments[i].contents.contains($0)
        }.map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        if !filteredContents.isEmpty {
            return SRT.Segment(
                index: segment.index,
                from: segment.startTime,
                to: segment.endTime,
                contents: filteredContents
            )
        }
    }

    return segment
}

let filteredCnSub = SRT(segments: filteredSegments)

do {
    try filteredCnSub.write(to: outputFilePath)
} catch {
    fatalError("Can not save file")
}
