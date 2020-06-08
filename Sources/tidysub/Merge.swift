//
//  Merge.swift
//  tidy sub
//
//  Created by Apollo Zhu on 6/8/20.
//  Copyright © 2020 Apollo nyan~. MIT License.
//

import srt

public func merge<T: Subtitle>(_ cnSub: T, with enSub: Subtitle) -> T {
    precondition(cnSub.segments.count == enSub.segments.count,
                 "Subtitles are of different count")
    return T(segments: zip(cnSub.segments, enSub.segments).enumerated().map {
        (i, segments) in
        let (cnSegment, enSegment) = segments
        let cnProcessed = cnSegment.contents.joined(separator: " ")
        let enProcessed = enSegment.contents.joined(separator: " ")
        let index = i + 1
        return SRT.Segment(
            index: index,
            from: cnSegment.startTime, to: cnSegment.endTime,
            contents: [cnProcessed, enProcessed]
        )
    })
}

