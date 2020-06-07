//
//  Remove English.swift
//  tidy sub
//
//  Created by Liuliet.Lee on 26/5/2020.
//  Copyright © 2020 Apollo nyan~. MIT License.
//

import srt

public func tidy<T: Subtitle>(
    cnSub: T, basedOnENSub enSub: Subtitle,
    process: (Int, [String]) -> [String]
) -> T {
    precondition(cnSub.segments.count == enSub.segments.count,
                 "Subtitles are of different count")
    return T(segments: zip(cnSub.segments, enSub.segments).enumerated().map {
        (i, segments) in
        let (cnSegment, enSegment) = segments

        let cnProcessed = cnSegment.contents
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        let enProcessed = enSegment.contents
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        let filtered = cnProcessed
            .filter { !enProcessed.contains($0) }
        let index = i + 1
        return SRT.Segment(
            index: index,
            from: cnSegment.startTime, to: cnSegment.endTime,
            contents: filtered.isEmpty ? cnProcessed : process(index, filtered)
        )
    })
}
